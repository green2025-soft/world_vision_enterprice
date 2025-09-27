<?php

namespace Modules\Inventory\Models;


class SupplierLedger extends InvBaseModel
{
    protected $fillable = [
        'supplier_id', 'date', 'transaction_type', 'debit', 'credit', 'balance','reference_id', 'reference_no', 'note', 'branch_id'
    ];

}
