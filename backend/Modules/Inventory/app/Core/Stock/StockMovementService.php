<?php 
<?php

namespace Modules\Inventory\Core;

use Modules\Inventory\Models\StockMovement;
use Exception;

class StockMovementService
{
    protected array $stockInTypes = [
        'purchase',
        'sale_return',
        'adjustment_in',
    ];

    protected array $stockOutTypes = [
        'sale',
        'purchase_return',
        'adjustment_out',
        'damage',
    ];

    /**
     * CREATE STOCK MOVEMENT
     */
    public function create(string $type, object $source, array $items): void
    {
        $this->validateType($type);

        foreach ($items as $item) {

            StockMovement::create([
                'product_id'    => $item['product_id'],
                'movement_type' => $type,
                'quantity'      => $item['quantity'],
                'unit_price'    => $item['unit_price'] ?? 0,
                'reference_id'  => $source->id ?? null,
                'branch_id'     => $source->branch_id ?? null,
                'created_by'    => auth()->id(),

                // IMPORTANT: always initialize
                'consumed_quantity' => 0,
            ]);
        }
    }

    /**
     * EDIT VALIDATION (ERP SAFE)
     */
    public function validateEdit(string $type, object $source, array $newItems): void
    {
        $existing = StockMovement::where('reference_id', $source->id)
            ->where('movement_type', $type)
            ->get()
            ->keyBy('product_id');

        foreach ($newItems as $item) {

            $productId = $item['product_id'];
            $newQty    = $item['quantity'];

            $old = $existing[$productId] ?? null;

            if (!$old) continue;

            $consumed = $old->consumed_quantity ?? 0;

            /**
             * 🔥 CRITICAL RULE:
             * cannot reduce below consumed stock
             */
            if ($this->isStockIn($type)) {

                if ($newQty < $consumed) {
                    throw new Exception(
                        "Cannot reduce below consumed stock for product ID: {$productId}"
                    );
                }
            }
        }
    }

    /**
     * DELETE VALIDATION (ERP SAFE)
     */
    public function validateDelete(string $type, int $referenceId): void
    {
        $movements = StockMovement::where('movement_type', $type)
            ->where('reference_id', $referenceId)
            ->get();

        foreach ($movements as $movement) {

            if ($this->isStockIn($type) && $movement->consumed_quantity > 0) {
                throw new Exception(
                    "Cannot delete: stock already consumed"
                );
            }
        }
    }

    /**
     * TYPE CHECK
     */
    public function isStockIn(string $type): bool
    {
        return in_array($type, $this->stockInTypes);
    }

    public function isStockOut(string $type): bool
    {
        return in_array($type, $this->stockOutTypes);
    }

    /**
     * VALIDATE TYPE
     */
    private function validateType(string $type): void
    {
        $allowed = array_merge($this->stockInTypes, $this->stockOutTypes);

        if (!in_array($type, $allowed)) {
            throw new Exception("Invalid movement type: {$type}");
        }
    }
}