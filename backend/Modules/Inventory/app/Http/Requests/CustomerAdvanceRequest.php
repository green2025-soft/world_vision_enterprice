<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class CustomerAdvanceRequest extends BaseRequest
{
    protected array $rules = [
        'customer_id'     => 'required|exists:inv_customers,id',
        'advance_amount'  => 'required|numeric|min:0.01',
        'date'            => 'required|date',
        'payment_method'  => 'nullable|string|max:50',
        'reference_no'    => 'nullable|string|max:100',
        'note'            => 'nullable|string',
    ];
}
