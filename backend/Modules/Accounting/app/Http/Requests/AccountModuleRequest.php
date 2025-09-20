<?php

namespace Modules\Accounting\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;

class AccountModuleRequest extends BaseRequest
{
    protected array $rules = [
        'module_name'   => 'required|string|max:255',
        'entry_type'    => 'required|string|max:255',
        'description'   => 'nullable|string',
        'status'        => 'boolean',

        // Accounts validation (nested array)
        'accounts'                      => 'required|array|min:1',
        'accounts.*.component'          => 'required|string|max:255',
        'accounts.*.account_head_id'    => 'required|exists:acc_account_heads,id',
        // 'accounts.*.is_debit'           => 'required|boolean',
        'accounts.*.description'        => 'nullable|string',

    ];

        public function messages(): array
        {
            return [
                'accounts.required'                     => 'At least one account configuration is required.',
                'accounts.*.component.required'         => 'Each account must have a component name.',
                'accounts.*.account_head_id.required'   => 'Each account must be linked to a valid account head.',
            ];
        }
}
