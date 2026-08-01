<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;

class CustomerLedger extends InvBaseModel
{
    protected $fillable = [
        'customer_id',
        'date',
        'transaction_type',
        'debit',
        'credit',
        'balance',
        'reference_id',
        'reference_no',
        'note',
        'branch_id'
    ];

    protected $casts = [
        'date' => 'date',
    ];

    /*
    |--------------------------------------------------------------------------
    | Scopes
    |--------------------------------------------------------------------------
    */

    public function scopeCustomer($query, $customerId)
    {
        return $query->when($customerId, function ($q) use ($customerId) {
            $q->where('customer_id', $customerId);
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

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    public function branch()
    {
        return $this->belongsTo(Branch::class);
    }
}