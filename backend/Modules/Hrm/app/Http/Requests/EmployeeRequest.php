<?php

namespace Modules\Hrm\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;
use Illuminate\Validation\Rule;

class EmployeeRequest extends BaseRequest
{
    public function rules(): array
    {
        $rules = [
            'first_name' => 'required|string|max:255',
            'last_name' => 'required|string|max:255',
            'father_name' => 'nullable|string|max:255',
            'mother_name' => 'nullable|string|max:255',
            'spouse_name' => 'nullable|string|max:255',
            'present_address' => 'nullable|string',
            'permanent_address' => 'nullable|string',
            'city' => 'nullable|string|max:255',
            'state' => 'nullable|string|max:255',
            'country' => 'nullable|string|max:255',
            'postal_code' => 'nullable|string|max:20',
            'department_id' => 'nullable|exists:hrm_departments,id',
            'designation_id' => 'nullable|exists:hrm_designations,id',
            'branch_id' => 'nullable|exists:branches,id',
            'gender_id' => 'nullable|exists:hrm_genders,id',
            'religion_id' => 'nullable|exists:hrm_religions,id',
            'nationality' => 'nullable|string|max:100',
            'marital_status' => 'nullable|in:Married,Unmarried,Divorced,Widowed',
            'date_of_birth' => 'nullable|date',
            'joining_date' => 'nullable|date',
            'confirmation_date' => 'nullable|date',
            'termination_date' => 'nullable|date',
            'shift_id' => 'nullable|exists:hrm_shifts,id',
            'probation_period' => 'nullable|string|max:10',
            'tin_no' => 'nullable|string|max:50',
            'employee_category_id' => 'nullable|exists:hrm_employee_categories,id',
            'employee_type_id' => 'nullable|exists:hrm_employee_types,id',
            'employee_status_id' => 'nullable|exists:hrm_employee_statuses,id',
            'blood_group_id' => 'nullable|exists:hrm_blood_groups,id',
            'profile_picture' => 'nullable|string|max:255',
            'remarks' => 'nullable|string',
        ];

        // ✅ Get the employee ID from route (for update)
        $employeeId = $this->route('id') ?? $this->route('employee');

        // ✅ Apply unique rules with ignore for update
        $rules['email'] = [
            'nullable',
            'email',
            Rule::unique('hrm_employees', 'email')->ignore($employeeId)
        ];

        $rules['phone'] = [
            'nullable',
            'string',
            Rule::unique('hrm_employees', 'phone')->ignore($employeeId)
        ];

        $rules['national_id'] = [
            'nullable',
            'string',
            Rule::unique('hrm_employees', 'national_id')->ignore($employeeId)
        ];

        $rules['passport_number'] = [
            'nullable',
            'string',
            Rule::unique('hrm_employees', 'passport_number')->ignore($employeeId)
        ];

        return $rules;
    }
}