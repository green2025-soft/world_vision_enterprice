<?php

namespace Modules\Core\Http\Requests;

use Illuminate\Support\Facades\Route;

class PermissionRequest extends BaseRequest
{
    protected array $rules = [
        'module_name'  => 'required',
        'section_name' => 'required',
        'route_name'   => 'required|unique:permissions,name',
        'role'         => ['required'], // base rule
    ];

    public function rules(): array
    {
        // Inherit base rules
        $rules = parent::rules();

        // Add closure-based rule dynamically
        $rules['role'][] = function ($attribute, $value, $fail) {
            if (!Route::has($value)) {
                $fail(__('The route name does not exist.'));
            }
        };

        return $rules;
    }
}
