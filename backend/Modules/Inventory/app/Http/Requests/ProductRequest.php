<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;
use Illuminate\Validation\Rule;
class ProductRequest extends BaseRequest
{

  protected array $rules = [
        'name'              => ['required', 'string', 'max:255'],
        'category_id'       => ['required', 'exists:inv_categories,id'],
        'unit_id'           => ['nullable', 'exists:inv_units,id'],
        'brand_id'          => ['nullable', 'exists:inv_brands,id'],
        'purchase_price'    => ['nullable', 'numeric', 'min:0'],
        'selling_price'     => ['nullable', 'numeric', 'min:0'],
        'stock_quantity'    => ['nullable', 'integer', 'min:0'],
        're_order'          => ['nullable', 'integer', 'min:0'],
        'made_by'           => ['nullable', 'string', 'max:255'],
        'upload_image'      => ['nullable'],
        'specification'     => ['nullable', 'string'],
        'status'            => ['nullable', 'boolean'],
        'branch_id'         => ['required', 'exists:branches,id'],
    ];
    

}
