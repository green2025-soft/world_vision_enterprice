<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
use Modules\Core\Models\User;
class CustomerPayment extends InvBaseModel
{
    protected $fillable = ['invoice_no', 'customer_id', 'payment_date', 'payment', 'adjustment', 'total_amount', 'note', 'branch_id', 'created_by'];

    protected array $searchable = ['invoice_no'];
    protected array $searchableRelations = ['customer'=>['name', 'phone']];

    protected static function boot()
    {
        parent::boot();

        static::saving(function ($model) {
            $model->total_amount = $model->payment + $model->adjustment;
        });
    }

     public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }
    
    public function user(){
        return $this->belongsTo(User::class, 'created_by');
    }

     public function customer(){
        return $this->belongsTo(Customer::class, 'customer_id');
    }

    
}
