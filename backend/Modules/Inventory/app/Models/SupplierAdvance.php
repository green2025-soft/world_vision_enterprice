<?php

namespace Modules\Inventory\Models;


class SupplierAdvance extends InvBaseModel
{
    protected $fillable = [
        'supplier_id', 'advance_amount', 'adjusted_amount', 'remaining_amount', 'date', 'payment_method', 'reference_no', 'note', 'type', 'branch_id'
    ];

    protected array $searchable = [];
    
    public function supplier()
    {
        return $this->belongsTo(Supplier::class, 'supplier_id');
    }


}
