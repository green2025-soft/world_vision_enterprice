<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
use Modules\Core\Models\User;
class PurchaseReturn extends InvBaseModel
{
    protected $fillable = ['invoice_no', 'purchase_id', 'supplier_id', 'return_date', 'total_return_amount', 'total_refund_amount', 'adjusted_due_amount', 'cash_refund_amount', 'supplier_advance', 'note', 'branch_id', 'created_by', 'status'];

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
        return $this->hasMany(PurchaseReturnItem::class, 'purchase_return_id');
    }

    
}
