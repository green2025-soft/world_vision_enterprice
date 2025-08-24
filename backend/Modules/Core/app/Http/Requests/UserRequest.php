<?php

namespace Modules\Core\Http\Requests;


use Illuminate\Validation\Rule;

class UserRequest extends BaseRequest
{
    
    protected array $rules = [
        'name'      => 'required|string|max:255',
        'email'     => 'required|email|unique:users,email',
        'password'  => 'required|string|min:6',
        'role'      => 'required|exists:roles,id', // validate role name
    ];


     public function rules(): array
    {
        if ($this->method() === 'PUT' || $this->method() === 'PATCH') {
            $this->rules['password'] ='nullable';

           $userId = $this->route('user');
              $this->rules['email'] = [
            'required',
            'email',
            Rule::unique('users', 'email')->ignore($userId),
        ];

        }

        return $this->rules;
    }


}
