<?php 

namespace Modules\Inventory\Services;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\StockBalance;

class StockBalanceService {

public function adjustStock(array $items, int $branchId, string $type='purchase', bool $isUpdate = false): void
{
    foreach ($items as $item) {

        $productId = $item['product_id'];
        $qty       = $item['quantity'];

        $stock = StockBalance::firstOrCreate(
            ['product_id' => $productId, 'branch_id' => $branchId],
            ['current_stock' => 0]
        );

        // 🔥 movement rules
        switch ($type) {

            case 'purchase':
            case 'sale_return':
                $stock->increment('current_stock', $qty);
                break;

            case 'sale':
            case 'purchase_return':

                if ($stock->current_stock < $qty) {
                    throw new \Exception("Insufficient stock for product ID: {$productId}");
                }

                $stock->decrement('current_stock', $qty);
                break;
        }
    }
}

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
    public function increaseStock($items, $branchId)
    {
        foreach ($items as $item) {
            StockBalance::updateOrCreate(
                ['product_id' => $item['product_id'], 'branch_id' => $branchId],
                ['current_stock' => DB::raw('current_stock + ' . $item['quantity'])]
            );
        }
    }

    public function decreaseStock($items, $branchId)
    {
        foreach ($items as $item) {
            StockBalance::where('product_id', $item['product_id'])
                ->where('branch_id', $branchId)
                ->decrement('current_stock', $item['quantity']);
        }
    }


    

    
}