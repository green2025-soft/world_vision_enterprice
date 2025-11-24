<?php

namespace Modules\Inventory\Models;


class CustomerLedger extends InvBaseModel
{
    protected $fillable = [
        'customer_id', 'date', 'transaction_type', 'debit', 'credit', 'balance','reference_id', 'reference_no', 'note', 'branch_id'
    ];

}
