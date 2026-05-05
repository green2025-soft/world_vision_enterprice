<?php

namespace Modules\Inventory\Services\Stock;

use Modules\Inventory\Models\StockBalance;
use Exception;

class StockBalanceService
{
    public function apply(string $type, array $item, int $branchId): void
    {
        $stock = StockBalance::firstOrCreate(
            [
                'product_id' => $item['product_id'],
                'branch_id'  => $branchId
            ],
            ['current_stock' => 0]
        );

        if (StockType::isStockIn($type)) {
            $stock->increment('current_stock', $item['quantity']);
        }

        if (StockType::isStockOut($type)) {

            if ($stock->current_stock < $item['quantity']) {
                throw new Exception("Insufficient stock");
            }

            $stock->decrement('current_stock', $item['quantity']);
        }
    }

    public function reverse(string $type, int $referenceId): void
    {
        // 🔥 Later improve (optional)
    }
}