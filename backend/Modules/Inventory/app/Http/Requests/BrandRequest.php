<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class BrandRequest extends BaseRequest
{
    protected array $rules = [
        'name'          => ['required', 'string', 'max:255'],
        'branch_id'     => ['required', 'exists:branches,id'],
    ];
}
