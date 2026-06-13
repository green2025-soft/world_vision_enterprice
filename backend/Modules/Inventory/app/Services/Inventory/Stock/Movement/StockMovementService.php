<?php

namespace Modules\Inventory\Services\Inventory\Stock\Movement;

use Modules\Inventory\Models\StockMovement;
use Modules\Inventory\Services\Inventory\Stock\StockType;
use Modules\Inventory\Services\Inventory\Stock\Movement\StockConsumptionService;
use Exception;

class StockMovementService
{

    public function __construct(

        protected StockConsumptionService $consumption,

    ) {}
    public function create(string $type, object $source, array $item): void
    {
        $consumedQuantity = StockType::isStockIn($type) ? 0 : null;
        
        if(StockType::SALE == $type && isset( $item['consumed_quantity'])){
            
            $consumedQuantity = $item['consumed_quantity'];
        }
        
        StockMovement::create([
            'product_id'    => $item['product_id'],
            'movement_type' => $type,
            'quantity'      => $item['quantity'],

            'unit_cost'     => $item['cost_price'] ?? 0,
            'unit_price'    => $item['unit_price'] ?? 0,

            'reference_id'  => $source->id,
            'branch_id'     => $source->branch_id,

            'consumed_quantity' =>  $consumedQuantity,
        ]);
    }

    public function delete(string $type, object $source){
        
        StockMovement::where(['movement_type'=>$type, 'reference_id'=> $source->id, 'branch_id'=> $source->branch_id])->delete();
    }

    public function reverse(string $type, int $referenceId, $model=''): void
    {
        $movements = StockMovement::where('reference_id', $referenceId)->get();
        
        foreach ($movements as $movement) {

            if (StockType::isStockIn($movement->movement_type)
                && ($movement->consumed_quantity ?? 0) > 0) {
                throw new Exception("Cannot reverse consumed stock");
            }
             
            if(($type =='sale_return' || $type =='purchase_return') &&  $model){
                $revRefKey = $type=='sale_return'?'sale_id':'purchase_id';
                 $this->consumption->updateStock(StockType::SALE_RETURN, $movement->product_id,$movement->branch_id, $model->$revRefKey, $movement->quantity, 'minus');
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