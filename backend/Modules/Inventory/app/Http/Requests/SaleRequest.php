<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class SaleRequest extends BaseRequest
{
    protected array $rules = [
         'customer_id'              => 'required|exists:inv_customers,id',
         'branch_id'                => 'required|exists:branches,id',
         'invoice_date'             => 'required|date',
         
         'items'                    => 'required|array|min:1',
         'items.*.product_id'       => 'required|exists:inv_products,id',
         'items.*.quantity'         => 'required|numeric|min:1',
         'items.*.unit_price'       => 'required|numeric|min:0',
         
         'items.*.sale_price'       => 'nullable|numeric|min:0',
         'items.*.discount_percent' => 'nullable|numeric|min:0|max:100',
         'items.*.tax_percent'      => 'nullable|numeric|min:0|max:100',
    ];
}
