<?php

namespace Modules\Core\Http\Requests;

use Illuminate\Validation\Rule;

class RoleRequest extends BaseRequest
{
    protected array $rules = [
        'name' => ['required', 'string', 'max:255', 'unique:roles,name'],
        'redirect_url' => ['nullable', 'string', 'max:255'],
        'direction' => ['nullable'],
        'guard_name' => ['nullable', 'string', 'max:255'],
    ];

    public function rules(): array
    {
        if ($this->method() === 'PUT' || $this->method() === 'PATCH') {
            $roleId  = $this->route('role')??null;
            $this->rules['name'] = [
                'required', 'string', 'max:255',
                Rule::unique('roles', 'name')->ignore($roleId),
            ];
        }

        return $this->rules;
    }
}
