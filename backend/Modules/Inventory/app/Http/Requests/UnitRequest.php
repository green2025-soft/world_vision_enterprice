<?php

namespace Modules\Inventory\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class UnitRequest extends BaseRequest
{
      protected array $rules = [
        'name'          => ['required', 'string', 'max:255'],
        'short_code'    => ['required', 'string', 'max:255'],
        'branch_id'     => ['required', 'exists:branches,id'],
    ];
}
