<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class PurchaseReturnRequest extends BaseRequest
{
    protected array $rules = [
         'supplier_id'              => 'required|exists:inv_suppliers,id',
         'branch_id'                => 'required|exists:branches,id',
         'return_date'              => 'required|date',
         
         'items'                    => 'required|array|min:1',
         'items.*.product_id'       => 'required|exists:inv_products,id',
         'items.*.return_qty'       => 'nullable|numeric|min:0',
         'items.*.wastage_qty'      => 'nullable|numeric|min:0',
         'items.*.return_unit_price'    => 'nullable|numeric|min:0',
         
         'items.*.purchase_price'       => 'nullable|numeric|min:0'
    ];

    public function withValidator($validator)
    {
        $validator->after(function ($validator) {
            $hasQty = collect($this->input('items', []))
                ->contains(function ($item) {
                    return ($item['return_qty'] ?? 0) >= 1
                        || ($item['wastage_qty'] ?? 0) >= 1;
                });

            if (! $hasQty) {
                $validator->errors()->add(
                    'items',
                    'At least one item must have return_qty or wastage_qty greater than or equal to 1.'
                );
            }
        });
}
}
