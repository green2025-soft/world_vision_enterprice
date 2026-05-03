<?php

namespace Modules\Inventory\Core\Stock;

use Modules\Inventory\Models\StockMovement;
use Exception;

class StockEngine
{
    protected string $strategy = 'fifo';

    protected array $stockInTypes = [
        'purchase',
        'sale_return',
    ];

    protected array $stockOutTypes = [
        'sale',
        'purchase_return',
    ];

    /**
     * MAIN ENTRY POINT
     */
    public function process(string $type, object $source, array $items): void
    {
        foreach ($items as $item) {

            if ($this->isStockOut($type)) {
                $this->consume($item['product_id'], $item['quantity'], $source->branch_id);
            }

            $this->createMovement($type, $source, $item);
        }
    }

    /**
     * CREATE STOCK MOVEMENT (ONLY LOG)
     */
    protected function createMovement(string $type, object $source, array $item): void
    {
        StockMovement::create([
            'product_id'    => $item['product_id'],
            'movement_type' => $type,
            'quantity'      => $item['quantity'],
            'unit_price'    => $item['unit_price'] ?? 0,
            'reference_id'  => $source->id,
            'branch_id'     => $source->branch_id ?? null,
            'created_by'    => auth()->id(),

            // ONLY for stock-in
            'consumed_quantity' => $this->isStockIn($type) ? 0 : null,
        ]);
    }

    /**
     * FIFO CONSUMPTION ENGINE
     */
    protected function consume(int $productId, float $qty, ?int $branchId): void
    {
        $remaining = $qty;

        $batches = StockMovement::where('product_id', $productId)
            ->whereIn('movement_type', $this->stockInTypes)
            ->whereColumn('consumed_quantity', '<', 'quantity')
            ->when($branchId, fn($q) => $q->where('branch_id', $branchId))
            ->orderBy('created_at', $this->strategy === 'fifo' ? 'asc' : 'desc')
            ->get();

        foreach ($batches as $batch) {

            $available = $batch->quantity - $batch->consumed_quantity;

            if ($available <= 0) continue;

            $use = min($available, $remaining);

            $batch->consumed_quantity += $use;
            $batch->save();

            $remaining -= $use;

            if ($remaining <= 0) break;
        }

        if ($remaining > 0) {
            throw new Exception("Insufficient stock for product ID: {$productId}");
        }
    }

    /**
     * REVERSE (EDIT SUPPORT)
     */
    public function reverse(string $type, int $referenceId): void
    {
        $movements = StockMovement::where('movement_type', $type)
            ->where('reference_id', $referenceId)
            ->get();

        foreach ($movements as $movement) {

            if ($this->isStockIn($type)) {

                // rollback consumed stock
                $this->rollbackConsumption($movement);
            }

            $movement->delete();
        }
    }

    /**
     * ROLLBACK CONSUMPTION
     */
    protected function rollbackConsumption($movement): void
    {
        $remaining = $movement->consumed_quantity ?? 0;

        if ($remaining <= 0) return;

        $batches = StockMovement::where('product_id', $movement->product_id)
            ->whereIn('movement_type', $this->stockInTypes)
            ->orderBy('created_at', 'desc')
            ->get();

        foreach ($batches as $batch) {

            if ($remaining <= 0) break;

            $used = min($batch->consumed_quantity, $remaining);

            $batch->consumed_quantity -= $used;
            $batch->save();

            $remaining -= $used;
        }
    }

    /**
     * HELPERS
     */
    protected function isStockIn(string $type): bool
    {
        return in_array($type, $this->stockInTypes);
    }

    protected function isStockOut(string $type): bool
    {
        return in_array($type, $this->stockOutTypes);
    }

    public function delete(string $type, int $referenceId): void
{
    $movements = StockMovement::where('movement_type', $type)
        ->where('reference_id', $referenceId)
        ->get();

    if ($movements->isEmpty()) {
        throw new Exception("No movements found");
    }

    foreach ($movements as $movement) {

        // 🔥 STEP 1: rollback stock if IN type
        if ($this->isStockIn($type)) {
            $this->rollbackConsumption($movement);
        }

        $movement->delete();
    }
}
}