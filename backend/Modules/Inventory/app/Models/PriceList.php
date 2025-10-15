<?php

namespace Modules\Inventory\Models;


class PriceList extends InvBaseModel
{
    protected $fillable = ['product_id', 'branch_id', 'price_type', 'price', 'start_date', 'end_date', 'remarks'];


    public function scopeForBranch($query, $branchId)
    {
        return $query->where('branch_id', $branchId);
    }

    
}
