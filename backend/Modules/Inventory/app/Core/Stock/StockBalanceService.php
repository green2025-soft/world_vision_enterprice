<?php 

namespace Modules\Inventory\Core\Stock;

use Modules\Inventory\Models\StockBalance;
use Illuminate\Support\Facades\DB;

class StockBalanceService
{
    public function increase(int $productId, int $branchId, float $qty): void
    {
        StockBalance::updateOrCreate(
            ['product_id' => $productId, 'branch_id' => $branchId],
            ['current_stock' => DB::raw("current_stock + {$qty}")]
        );
    }

    public function decrease(int $productId, int $branchId, float $qty): void
    {
        $stock = StockBalance::where([
            'product_id' => $productId,
            'branch_id' => $branchId
        ])->lockForUpdate()->first();

        if (!$stock || $stock->current_stock < $qty) {
            throw new \Exception("INSUFFICIENT STOCK");
        }

        $stock->decrement('current_stock', $qty);
    }

    public function get(int $productId, int $branchId): float
    {
        return StockBalance::where(compact('productId','branchId'))
            ->value('current_stock') ?? 0;
    }
}