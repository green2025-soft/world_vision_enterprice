<?php

namespace Modules\Core\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class BranchRequest extends BaseRequest
{
    protected array $rules = [
        'name' => ['required', 'string', 'max:255'],
        // 'name' => ['nullable', 'string', 'max:255'],
        'contact_no' => ['nullable', 'string', 'max:20'],
       'fileLogo' => ['nullable'],// Image path string
    ];
}
