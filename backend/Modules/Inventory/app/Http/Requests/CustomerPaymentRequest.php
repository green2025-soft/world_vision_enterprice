<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class CustomerPaymentRequest extends BaseRequest
{
    protected array $rules = [
         'customer_id'              => 'required|exists:inv_customers,id',
         'branch_id'                => 'required|exists:branches,id',
         'payment_date'             => 'required|date',
         'payment'                  => 'required|numeric|min:0',
         'adjustment'               => 'nullable|numeric|min:0',
    ];
}
