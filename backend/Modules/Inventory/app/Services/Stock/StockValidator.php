<?php

namespace Modules\Inventory\Services\Stock;

use Modules\Inventory\Models\StockBalance;
use Exception;

class StockValidator
{
    public function validate(string $type, array $item, int $branchId): void
    {
        if (StockType::isStockOut($type)) {

            $stock = StockBalance::where('product_id', $item['product_id'])
                ->where('branch_id', $branchId)
                ->value('current_stock') ?? 0;

            if ($stock < $item['quantity']) {
                throw new Exception("Insufficient stock for product ID: {$item['product_id']}");
            }
        }
    }
}