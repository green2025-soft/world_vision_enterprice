<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
use Modules\Core\Models\User;
class SaleReturn extends InvBaseModel
{
    protected $fillable = ['return_no', 'sale_id', 'customer_id', 'return_date', 'total_return_amount', 'adjusted_due_amount', 'cash_refund_amount', 'store_credit_amount', 'note', 'branch_id', 'created_by', 'status'];

    protected array $searchable = [];

     public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }
    
    public function user(){
        return $this->belongsTo(User::class, 'created_by');
    }

     public function customer(){
        return $this->belongsTo(Customer::class, 'customer_id');
    }

    public function items()
    {
        return $this->hasMany(SaleReturnItem::class, 'sale_return_id');
    }

    
}
