<?php

namespace Modules\Hrm\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class BloodGroupRequest extends BaseRequest
{
    protected array $rules = [
        'name'          => 'required',
        'status'        => 'required|boolean',
    ];
}
