<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;

class SaleReturnItem extends InvBaseModel
{
    protected $fillable = ['sale_return_id', 'sale_item_id', 'product_id', 'sold_qty', 'return_qty', 'sale_unit_price', 'return_unit_price', 'branch_id'];


    public function product(){
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function currentStock(){
        return $this->belongsTo(StockBalance::class, 'product_id', 'product_id');
    }

    public function return(){
        return $this->belongsTo(SaleReturn::class, 'sale_return_id');
    }


    public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }

    
}
