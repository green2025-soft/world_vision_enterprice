<?php

namespace Modules\Inventory\Services;

use Modules\Inventory\Models\StockMovement;
use Exception;

class StockMovementService
{
    protected string $strategy;

    protected array $stockInTypes = [
        'purchase', 'transfer_in', 'adjustment_in', 'sale_return'
    ];

    protected array $stockOutTypes = [
        'sale', 'transfer_out', 'damage', 'purchase_return', 'adjustment_out'
    ];

    public function __construct(string $strategy = null)
    {
        $this->strategy = $strategy ?? env('STOCK_STRATEGY', 'fifo');
    }

    /**
     * Handle stock movement for any operation
     */
    public function handle(string $movementType, object $source, array $items): void
    {
        $this->validateMovementType($movementType);

        $branchId = $source->branch_id ?? null;

        foreach ($items as $item) {
            $productId = $item['product_id'];
            $quantity = $item['quantity'];

            if ($this->isStockOutType($movementType)) {
                $this->consumeStock($productId, $quantity, $branchId);
            }

            $data = $this->prepareMovementData($movementType, $source, $item, $branchId);

            StockMovement::create($data);
        }
    }

    /**
     * Prepare data array for StockMovement creation
     */
    protected function prepareMovementData(string $movementType, object $source, array $item, ?int $branchId): array
    {
        $data = [
            'product_id'       => $item['product_id'],
            'movement_type'    => $movementType,
            'quantity'         => $item['quantity'],
            'unit_price'       => $item['unit_price'] ?? null,
            'sales_price'      => $item['sale_price'] ?? null,
            'strategy'         => $this->strategy,
            'purchase_item_id' => $item['purchase_item_id'] ?? null,
            'reference_id'     => $source->id,
            'branch_id'        => $branchId,
            'created_by'       => auth()->id(),
        ];

        if ($this->isStockInType($movementType)) {
            $data['consumed_quantity'] = 0;
        }

        return $data;
    }

    /**
     * Consume stock using FIFO or LIFO strategy
     */
    protected function consumeStock(int $productId, float $quantity, ?int $branchId = null): array
    {
        $direction = $this->strategy === 'lifo' ? 'desc' : 'asc';
        $remaining = $quantity;
        $consumed = [];

        $inMovements = StockMovement::where('product_id', $productId)
            ->whereIn('movement_type', $this->stockInTypes)
            ->where(function ($q) {
                $q->whereNull('consumed_quantity')
                  ->orWhereColumn('consumed_quantity', '<', 'quantity');
            })
            ->when($branchId, fn ($q) => $q->where('branch_id', $branchId))
            ->orderBy('created_at', $direction)
            ->get();

        foreach ($inMovements as $movement) {
            $available = $movement->quantity - ($movement->consumed_quantity ?? 0);
            if ($available <= 0) {
                continue;
            }

            $toConsume = min($remaining, $available);
            $movement->consumed_quantity = ($movement->consumed_quantity ?? 0) + $toConsume;
            $movement->save();

            $consumed[] = [
                'source_movement_id' => $movement->id,
                'product_id'         => $productId,
                'consumed_quantity'  => $toConsume,
                'unit_price'         => $movement->unit_price,
            ];

            $remaining -= $toConsume;
            if ($remaining <= 0) {
                break;
            }
        }

        if ($remaining > 0) {
            throw new Exception("Insufficient stock for product ID: {$productId}");
        }

        return $consumed;
    }

    /**
     * Validate allowed movement types
     */
    protected function validateMovementType(string $movementType): void
    {
        $allowedTypes = array_merge($this->stockInTypes, $this->stockOutTypes);

        if (!in_array($movementType, $allowedTypes)) {
            throw new Exception("Invalid movement type: {$movementType}");
        }
    }

    /**
     * Check if movement is stock-in type
     */
    protected function isStockInType(string $movementType): bool
    {
        return in_array($movementType, $this->stockInTypes);
    }

    /**
     * Check if movement is stock-out type
     */
    protected function isStockOutType(string $movementType): bool
    {
        return in_array($movementType, $this->stockOutTypes);
    }

    /**
     * Get current stock balance for product and branch
     */
    public function getLastStock(int $productId, ?int $branchId = null): float
    {
        $inQuantity = StockMovement::where('product_id', $productId)
            ->whereIn('movement_type', $this->stockInTypes)
            ->when($branchId, fn ($q) => $q->where('branch_id', $branchId))
            ->sum('quantity');

        $outQuantity = StockMovement::where('product_id', $productId)
            ->whereIn('movement_type', $this->stockOutTypes)
            ->when($branchId, fn ($q) => $q->where('branch_id', $branchId))
            ->sum('quantity');

        return $inQuantity - $outQuantity;
    }

    /**
     * Validate stock constraints before editing a stock movement
     */
    public function validateEdit(string $movementType, object $source, array $items): void
    {
        $existingMovements = StockMovement::where('movement_type', class_basename($source))
            ->where('reference_id', $source->id)
            ->get()
            ->keyBy('product_id');

        foreach ($items as $item) {
            $productId = $item['product_id'];
            $newQuantity = $item['quantity'];
            $oldQuantity = $existingMovements[$productId]->quantity ?? 0;
            $diff = $newQuantity - $oldQuantity;

            if ($this->isStockOutType($movementType) && $diff > 0) {
                $availableStock = $this->getLastStock($productId, $source->branch_id);
                if ($availableStock < $diff) {
                    throw new Exception("Insufficient stock to increase quantity for product ID: {$productId}");
                }
            }

            if ($this->isStockInType($movementType) && $diff < 0) {
                $consumedQuantity = $existingMovements[$productId]->consumed_quantity ?? 0;
                if ($newQuantity < $consumedQuantity) {
                    throw new Exception("Cannot reduce quantity below consumed stock for product ID: {$productId}");
                }
            }
        }
    }

    /**
     * Validate stock constraints before deleting a stock movement
     */
    public function validateDelete(string $movementType, int $referenceId): void
    {
        $movements = StockMovement::where('movement_type', $movementType)
            ->where('reference_id', $referenceId)
            ->get();

        if ($movements->isEmpty()) {
            throw new Exception("No stock movements found for movement type {$movementType} and reference ID {$referenceId}");
        }

        foreach ($movements as $movement) {
            if ($this->isStockInType($movement->movement_type) && ($movement->consumed_quantity ?? 0) > 0) {
                throw new Exception("Cannot delete stock movements for {$movementType} ID {$referenceId} because some quantities are already consumed.");
            }
        }
    }
}
