<?php

namespace Modules\Hrm\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class LeaveRequest extends BaseRequest
{
    protected array $rules = [
        'employee_id'       => 'required',
        'department_id'     => 'required',
        'designation_id'    => 'required',
        'leave_category_id' => 'required',
        'application_date'  => 'required',
        'leave_from'        => 'required',
        'leave_to'          => 'required',
        'status'            => 'required|boolean',
    ];
}
