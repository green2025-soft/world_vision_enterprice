<?php

namespace Modules\Hrm\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class DesignationRequest extends BaseRequest
{
    protected array $rules = [
        'name'          => 'required',
        'status'        => 'required|boolean',
    ];
}
