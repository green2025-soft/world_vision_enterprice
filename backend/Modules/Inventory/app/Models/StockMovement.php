<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
use Modules\Inventory\Services\Stock\StockType;

class StockMovement extends InvBaseModel
{
    protected $fillable = ['product_id', 'movement_type', 'quantity', 'consumed_quantity', 'unit_cost','unit_price', 'reference_id', 'branch_id', 'strategy'];


    public function product(){
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function purchaseItem(){
        return $this->belongsTo(PurchaseItem::class, 'purchase_item_id');
    }


    public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }


     /*
    |--------------------------------------------------------------------------
    | Scopes
    |--------------------------------------------------------------------------
    */
    
    public function scopeForBranch($query,$branchId)
    {
        return $query->where(
            'branch_id',
            $branchId
        );
    }



    public function scopeForProduct($query,$productId=null)
    {
        return $query->when(
            $productId,
            fn($q)=>$q->where(
                'product_id',
                $productId
            )
        );
    }



    public function scopeBeforeDate($query,$date)
    {
        return $query->whereDate(
            'created_at',
            '<',
            $date
        );
    }



    public function scopeBetweenDates($query,$from,$to)
    {
        return $query->whereBetween(
            'created_at',
            [
                $from,
                $to
            ]
        );
    }



    public function scopeStockIn($query)
    {
        return $query->whereIn(
            'movement_type',
            StockType::stockIn()
        );
    }



    public function scopeStockOut($query)
    {
        return $query->whereIn(
            'movement_type',
            StockType::stockOut()
        );
    }

    
}
