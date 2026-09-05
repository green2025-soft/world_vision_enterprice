<?php

namespace Modules\Hrm\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class ShiftRequest extends BaseRequest
{
    protected array $rules = [
        'name'          => 'required',
        'status'        => 'required|boolean',
    ];
}
