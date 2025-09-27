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
                ['quantity' => DB::raw('quantity + ' . $item['quantity']), 'branch_id'=>$branchId]
            );
        }
    }
    
}