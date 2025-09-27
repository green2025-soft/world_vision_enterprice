<?php

namespace Modules\Accounting\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;
use Illuminate\Validation\Rule;

class AccountModuleRequest extends BaseRequest
{
    protected array $rules = [
        'module_name'   => 'required|string|max:255|unique:acc_module_entries,module_name',
        'entry_type'    => 'required|string|max:255|unique:acc_module_entries,entry_type',
        'description'   => 'nullable|string',
        'status'        => 'boolean',

        // Accounts validation (nested array)
        'accounts'                      => 'required|array|min:1',
        'accounts.*.component'          => 'required|string|max:255',
        'accounts.*.account_head_id'    => 'required|exists:acc_account_heads,id',
        'accounts.*.is_debit'           => 'nullable|boolean',
        'accounts.*.description'        => 'nullable|string',

    ];
    
    public function rules(): array
    {
        if (in_array($this->method(), ['PUT', 'PATCH'])) {
         $id = $this->route('account_module') ?? null;
          $this->rules['module_name'] = [
            'required',
            'string',
            'max:255',
            Rule::unique('acc_module_entries', 'module_name')->ignore($id),
          ];
            $this->rules['entry_type']= [
                'required',
                'string',
                'max:255',
                Rule::unique('acc_module_entries', 'entry_type')->ignore($id),
            ];

        }

        return $this->rules;
    }

        public function messages(): array
        {
            return [
                'accounts.required'                     => 'At least one account configuration is required.',
                'accounts.*.component.required'         => 'Each account must have a component name.',
                'accounts.*.account_head_id.required'   => 'Each account must be linked to a valid account head.',
            ];
        }
}
