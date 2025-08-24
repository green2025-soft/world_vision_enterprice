<?php

namespace Modules\Inventory\Models;


class Customer extends InvBaseModel
{
    protected $fillable = [
        'name', 'phone', 'email', 'address',
        'previous_due', 'advance_amount',
        'status', 'branch_id'
    ];

    protected array $searchable = ['name', 'phone', 'email'];
}
