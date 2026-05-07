<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
use Modules\Core\Models\User;
class Sale extends InvBaseModel
{
    protected $fillable = ['invoice_no', 'customer_id', 'invoice_date', 'total_amount', 'discount_percent', 'discount_amount', 'total_discount_percent', 'total_discount_amount', 'adjustment', 'tax_percent', 'tax_amount', 'total_tax_percent', 'total_tax_amount', 'supplier_adjust', 'net_total', 'paid_amount', 'due_amount', 'remarks', 'branch_id', 'created_by'];

    protected array $searchable = [
        'invoice_no',
        'invoice_date',
    ];

    // protected array $searchableRelations = [
    //     'name','phone'
    // ];

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
        return $this->hasMany(SaleItem::class, 'sale_id');
    }

    public function stockMovements()
    {
        return $this->hasMany(StockMovement::class, 'reference_id', 'sale_id')->where('movement_type', 'sale');
    }

   

    
}
