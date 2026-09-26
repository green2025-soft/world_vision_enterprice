<?php

namespace Modules\Accounting\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;
use Illuminate\Validation\Rule;
use Modules\Accounting\Models\AccountHead;

class AccountHeadRequest extends BaseRequest
{
    protected array $rules = [
        'name'          => 'required',
        // 'code'          => 'required|unique:acc_account_heads,code',
        'parent_id'     => 'required|exists:acc_account_heads,id',
        'branch_id'     => ['nullable', 'exists:branches,id'],
        'status'        => 'required|boolean',
    ];



    public function rules(): array
    {
        $rules = $this->rules;
        $rules['cash_flow_activity'] = ['nullable', Rule::in(['operating', 'investing', 'financing', 'unclassified'])];
        $rules['system_key'] = [
            'nullable',
            Rule::in([AccountHead::INCOME_OVER_EXPENDITURE_KEY, 'cash_in_hand', 'cash_at_bank', 'equity_funds']),
            Rule::unique('acc_account_heads', 'system_key')->ignore($this->route('chart_of_account')),
        ];

        if (in_array($this->method(), ['PUT', 'PATCH'])) {
            $rules['code'] = [
                'required',
                'max:255',
                Rule::unique('acc_account_heads', 'code')->ignore($this->route('chart_of_account')),
            ];
        }

        return $rules;
    }

    public function withValidator($validator): void
    {
        $validator->after(function ($validator) {
            if ($validator->errors()->isNotEmpty() || !$this->input('system_key')) {
                return;
            }
            $parent = AccountHead::find($this->input('parent_id'));
            $root = in_array($this->input('system_key'), [AccountHead::INCOME_OVER_EXPENDITURE_KEY, 'equity_funds'], true) ? 'equity_liability' : 'asset';
            if (!$parent || $parent->root()->code !== AccountHead::MAIN_CODES[$root] || $parent->level > 3) {
                $validator->errors()->add('system_key', 'Assign this report role under the appropriate root (cash/bank under Assets, earnings under Funds & Liabilities), up to ledger account level.');
            }
        });
    }

    public function messages(): array
    {
        return [
            'system_key.unique' => 'This report role is already assigned to another account. Remove it there before assigning it here.',
        ];
    }

}
