<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class SupplierPaymentRequest extends BaseRequest
{
    protected array $rules = [
         'supplier_id'              => 'required|exists:inv_suppliers,id',
         'branch_id'                => 'required|exists:branches,id',
         'payment_date'             => 'required|date',
         'payment'                  => 'required|numeric|min:0',
         'adjustment'               => 'nullable|numeric|min:0',
    ];
}
