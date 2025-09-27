<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class SupplierAdvanceRequest extends BaseRequest
{
    protected array $rules = [
        'supplier_id'     => 'required|exists:inv_suppliers,id',
        'advance_amount'  => 'required|numeric|min:0.01',
        'date'            => 'required|date',
        'payment_method'  => 'nullable|string|max:50',
        'reference_no'    => 'nullable|string|max:100',
        'note'            => 'nullable|string',
    ];
}
