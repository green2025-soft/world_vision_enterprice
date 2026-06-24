<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class StockTransferRequest extends BaseRequest
{
    protected array $rules = [

        'from_branch_id' => 'required|exists:branches,id',
        'to_branch_id'   => 'required|exists:branches,id',

        'transfer_date'  => 'required|date',

        'note'           => 'nullable|string',

        /*
        |--------------------------------------------------------------------------
        | Items
        |--------------------------------------------------------------------------
        */

        'items'                  => 'required|array|min:1',

        'items.*.product_id'     => 'required|exists:inv_products,id',

        'items.*.quantity'       => 'required|numeric|min:0.01',

        'items.*.unit_cost'      => 'nullable|numeric|min:0',

        'items.*.total_cost'     => 'nullable|numeric|min:0',
    ];

    public function withValidator($validator): void
    {
        $validator->after(function ($validator) {

            /*
            |--------------------------------------------------------------------------
            | Same Branch Validation
            |--------------------------------------------------------------------------
            */

            if ($this->from_branch_id == $this->to_branch_id) {

                $validator->errors()->add(
                    'to_branch_id',
                    'From branch and To branch cannot be the same.'
                );
            }

            /*
            |--------------------------------------------------------------------------
            | At least one valid qty
            |--------------------------------------------------------------------------
            */

            $hasQty = collect($this->input('items', []))
                ->contains(function ($item) {

                    return ($item['quantity'] ?? 0) > 0;
                });

            if (! $hasQty) {

                $validator->errors()->add(
                    'items',
                    'At least one item quantity must be greater than 0.'
                );
            }
        });
    }
}
