<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;

class ProductWastageItem extends InvBaseModel
{
    protected $fillable = ['product_wastage_id', 'product_id', 'quantity', 'unit_cost', 'total_cost'];


    public function product(){
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function currentStock(){
        return $this->belongsTo(StockBalance::class, 'product_id', 'product_id');
    }

    public function productWastage(){
        return $this->belongsTo(ProductWastage::class, 'product_wastage_id');
    }


    
}
