<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
use Modules\Core\Models\User;
class Purchase extends InvBaseModel
{
    protected $fillable = ['invoice_no', 'supplier_id', 'invoice_date', 'total_amount', 'discount_percent', 'discount_amount', 'tax_percent', 'tax_amount', 'supplier_adjust', 'net_total', 'paid_amount', 'due_amount', 'remarks', 'branch_id', 'created_by'];

    protected array $searchable = [];

     public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }
    
    public function user(){
        return $this->belongsTo(User::class, 'created_by');
    }

     public function supplier(){
        return $this->belongsTo(Supplier::class, 'supplier_id');
    }

    public function items()
    {
        return $this->hasMany(PurchaseItem::class, 'purchase_id');
    }




}
