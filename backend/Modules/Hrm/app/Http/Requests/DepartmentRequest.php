<?php

namespace Modules\Hrm\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class DepartmentRequest extends BaseRequest
{
    protected array $rules = [
        'name'          => 'required',
        'status'        => 'required|boolean',
    ];
}
