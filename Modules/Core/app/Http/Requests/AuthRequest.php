<?php

namespace Modules\Core\Http\Requests;



class AuthRequest extends BaseRequest
{
    protected array $rules = [
        'email'    => ['required', 'email'],
        'password' => ['required', 'string'],
    ];


}
