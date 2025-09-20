<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class ProductSetRequest extends BaseRequest
{
    protected array $rules = [
        'name'                  => 'required|string',
        'discount'              => 'nullable|numeric|min:0',
        'branch_id'             => 'required|exists:branches,id',
        // items
        'items'                 => 'required|array|min:1',
        'items.*.product_id'    => 'required|exists:inv_products,id',
        'items.*.qty'           => 'required|integer|min:1',
        'items.*.price'         => 'nullable|numeric|min:0',
    ];
}
