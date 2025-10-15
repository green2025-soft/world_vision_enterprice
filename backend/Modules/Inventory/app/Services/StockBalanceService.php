<?php 

namespace Modules\Inventory\Services;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\StockBalance;

class StockBalanceService {

    public function updateFromPurchase(array $items, $branchId)
    {
        
        foreach ($items as $item) {
            StockBalance::updateOrCreate(
                ['product_id' => $item['product_id'], 'branch_id'=>$branchId],
                ['current_stock' => DB::raw('current_stock + ' . $item['quantity']), 'branch_id'=>$branchId]
            );
        }
    }

    public function rollbackFromPurchase(array $items, $branchId): void
{
    foreach ($items as $item) {
        StockBalance::where('product_id', $item['product_id'])
            ->where('branch_id', $branchId)
            ->decrement('current_stock', $item['quantity']);
    }
}

    
}