<?php

namespace Modules\Inventory\Models;


class Supplier extends InvBaseModel
{
    protected $fillable = [
        'name', 'phone', 'email', 'address',
        'previous_due', 'advance_amount',
        'status', 'branch_id'
    ];

    protected array $searchable = ['name', 'phone', 'email'];

    // Supplier.php

    public function branchBalance($branchId)
    {
        return $this->hasOne(SupplierLedger::class)
            ->selectRaw('supplier_id, SUM(debit - credit) as balance')
            ->where('branch_id', $branchId)
            ->groupBy('supplier_id');
    }

  

}
