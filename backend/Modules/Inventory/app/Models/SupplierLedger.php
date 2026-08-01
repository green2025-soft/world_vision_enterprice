<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
class SupplierLedger extends InvBaseModel
{
    protected $fillable = [
        'supplier_id', 'date', 'transaction_type', 'debit', 'credit', 'balance','reference_id', 'reference_no', 'note', 'branch_id'
    ];


     protected $casts = [
        'date' => 'date',
    ];

    /*
    |--------------------------------------------------------------------------
    | Scopes
    |--------------------------------------------------------------------------
    */

    public function scopeSupplier($query, $supplierId)
    {
        return $query->when($supplierId, function ($q) use ($supplierId) {
            $q->where('supplier_id', $supplierId);
        });
    }

    public function scopeBranch($query, $branchId)
    {
        return $query->when($branchId, function ($q) use ($branchId) {
            $q->where('branch_id', $branchId);
        });
    }

    public function scopeDateRange($query, $from, $to)
    {
        return $query->whereBetween('date', [$from, $to]);
    }

    public function scopeBeforeDate($query, $date)
    {
        return $query->whereDate('date', '<', $date);
    }

    /*
    |--------------------------------------------------------------------------
    | Relationships
    |--------------------------------------------------------------------------
    */

    public function supplier()
    {
        return $this->belongsTo(Supplier::class);
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }

}
