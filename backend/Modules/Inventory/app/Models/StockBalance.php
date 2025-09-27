<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;

class StockBalance extends InvBaseModel
{
    protected $fillable = ['product_id', 'branch_id', 'current_stock'];


    public function product(){
        return $this->belongsTo(Product::class, 'product_by');
    }


    public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }

    
}
