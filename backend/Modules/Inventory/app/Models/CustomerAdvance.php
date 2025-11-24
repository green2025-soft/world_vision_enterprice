<?php

namespace Modules\Inventory\Models;


class CustomerAdvance extends InvBaseModel
{
    protected $fillable = [
        'customer_id', 'advance_amount', 'adjusted_amount', 'remaining_amount', 'date', 'payment_method', 'reference_no', 'note', 'type', 'branch_id'
    ];

    protected array $searchable = [];

     public function customer()
    {
        return $this->belongsTo(Customer::class, 'customer_id');
    }
}
