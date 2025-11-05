<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;

class PurchaseItem extends InvBaseModel
{
    protected $fillable = ['purchase_id', 'product_id', 'invoice_date', 'quantity', 'unit_price','cost_price','inventory_subtotal', 'sale_price', 'total_price', 'discount_percent', 'discount_amount', 'tax_percent', 'tax_amount', 'net_price', 'remarks', 'branch_id'];


    public function product(){
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function purchase(){
        return $this->belongsTo(Purchase::class, 'purchase_id');
    }


    public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }

    
}
