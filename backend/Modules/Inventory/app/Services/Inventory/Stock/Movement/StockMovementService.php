<?php

namespace Modules\Inventory\Services\Inventory\Stock\Movement;

use Modules\Inventory\Models\StockMovement;
use Modules\Inventory\Services\Inventory\Stock\StockType;
use Exception;

class StockMovementService
{
    public function create(string $type, object $source, array $item): void
    {
        StockMovement::create([
            'product_id'    => $item['product_id'],
            'movement_type' => $type,
            'quantity'      => $item['quantity'],

            'unit_cost'     => $item['cost_price'] ?? 0,
            'unit_price'    => $item['unit_price'] ?? 0,

            'reference_id'  => $source->id,
            'branch_id'     => $source->branch_id,

            'consumed_quantity' => StockType::isStockIn($type) ? 0 : null,
        ]);
    }

    public function reverse(string $type, int $referenceId): void
    {
        $movements = StockMovement::where('reference_id', $referenceId)->get();

        foreach ($movements as $movement) {

            if (StockType::isStockIn($movement->movement_type)
                && ($movement->consumed_quantity ?? 0) > 0) {
                throw new Exception("Cannot reverse consumed stock");
            }

            $movement->delete();
        }
    }

    public function getPreviousQty(
        int $productId,
        int $branchId,
        int $referenceId,
        array $type
    ): float {
        return StockMovement::where('product_id', $productId)
            ->where('branch_id', $branchId)
            ->where('reference_id', $referenceId)
            ->whereIn('movement_type', $type)
            ->sum('quantity');
    }
}