<?php

namespace Modules\Core\Http\Requests;

class AssignPermissionRequest extends BaseRequest
{
    protected array $rules = [
        'role_id'       => ['required', 'exists:roles,id'],
        'permissions'   => ['required', 'array', 'min:1'],
        'permissions.*' => ['required', 'exists:permissions,id'],
    ];

    protected array $messages = [
        'role_id.required'       => 'A role must be selected.',
        'role_id.exists'         => 'The selected role is invalid.',
        'permissions.required'   => 'At least one permission must be selected.',
        'permissions.array'      => 'Permissions must be an array.',
        'permissions.*.exists'   => 'One or more selected permissions are invalid.',
    ];
}
