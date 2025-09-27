<?php

namespace Modules\Inventory\Services\Purchase;

use Modules\Inventory\Models\StockMovement;

class StockMovementService
{
    protected string $strategy;

    /**
     * Constructor with optional strategy (default: fifo)
     */
    public function __construct(string $strategy = null)
    {
        $this->strategy = $strategy ?? config('inventory.stock_strategy', 'fifo'); // Optional config support
    }

    /**
     * Handle stock movement for any operation (purchase, sale, return, adjustment)
     *
     * @param string $movementType   e.g. 'in', 'out', 'return_in', 'adjustment_out'
     * @param object $source         Eloquent model: Purchase, Sale, etc.
     * @param array $items           Array of item data
     * @param string|null $referenceType Optional (e.g. 'purchase', 'sale')
     * @return void
     */
    public function handle(
        string $movementType,
        object $source,
        array $items,
        ?string $referenceType = null
    ): void {
        foreach ($items as $item) {
            StockMovement::create([
                'product_id'        => $item['product_id'],
                'movement_type'     => $movementType,
                'quantity'          => $item['quantity'],
                'unit_price'        => $item['unit_price'] ?? null,
                'sales_price'       => $item['sale_price'] ?? null,
                'strategy'          => $this->strategy,
                'purchase_item_id'  => $item['purchase_item_id'] ?? null,
                'reference_type'    => $referenceType ?? class_basename($source),
                'reference_id'      => $source->id,
                'branch_id'         => $source->branch_id,
                'remarks'           => $item['remarks'] ?? null,
                'created_by'        => auth()->id(),
            ]);
        }
    }
}
