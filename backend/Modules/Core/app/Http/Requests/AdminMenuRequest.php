<?php

namespace Modules\Core\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class AdminMenuRequest extends BaseRequest
{
     protected array $rules = [
        'title'             => ['required', 'string', 'max:255'],
        'module_id'         => ['required', 'integer', 'min:0'],
        'route'             => ['nullable', 'string', 'max:255'], // Laravel route name
        'icon'              => ['nullable', 'string', 'max:100'],
        'parent_id'         => ['nullable', 'integer', 'exists:admin_menus,id'],
        'permission_route'  => ['nullable', 'string', 'max:255'],
        'status'            => ['nullable', 'boolean'],
    ];
}
