<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;

class StockTransferItem extends InvBaseModel
{
    protected $fillable = ['stock_transfer_id', 'product_id', 'quantity', 'unit_cost', 'total_cost'];


    public function product(){
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function currentStock(){
        return $this->belongsTo(StockBalance::class, 'product_id', 'product_id');
    }

    public function transfer(){
        return $this->belongsTo(StockTransfer::class, 'stock_transfer_id');
    }


    
}
