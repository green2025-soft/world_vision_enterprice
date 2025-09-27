<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;

class StockMovement extends InvBaseModel
{
    protected $fillable = ['product_id', 'movement_type', 'quantity', 'unit_price', 'sales_price', 'purchase_item_id', 'reference_id', 'branch_id'];


    public function product(){
        return $this->belongsTo(Product::class, 'product_by');
    }

    public function purchaseItem(){
        return $this->belongsTo(PurchaseItem::class, 'purchase_item_id');
    }


    public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }

    
}
