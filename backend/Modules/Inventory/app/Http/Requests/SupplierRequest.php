<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class SupplierRequest extends BaseRequest
{
  protected array $rules = [
        'name'              => ['required', 'string', 'max:255'],
        'phone'             => ['nullable', 'string', 'max:20'],
        'email'             => ['nullable', 'email', 'max:255'],
        'address'           => ['nullable', 'string'],
        'previous_due'      => ['nullable', 'numeric', 'min:0'],
        'advance_amount'    => ['nullable', 'numeric', 'min:0'],
        'status'            => ['nullable', 'boolean'],
        'branch_id'         => ['required', 'exists:branches,id'],
    ];
}
