<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class SaleReturnRequest extends BaseRequest
{
    protected array $rules = [
         'customer_id'              => 'required|exists:inv_customers,id',
         'branch_id'                => 'required|exists:branches,id',
         'return_date'              => 'required|date',
         
         'items'                    => 'required|array|min:1',
         'items.*.product_id'       => 'required|exists:inv_products,id',
         'items.*.wastage_qty'      => 'nullable|numeric|min:0',
         'items.*.return_unit_price'    => 'nullable|numeric|min:0',
         
         'items.*.sale_price'       => 'nullable|numeric|min:0'
    ];
}
