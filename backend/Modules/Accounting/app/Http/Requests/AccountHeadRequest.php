<?php

namespace Modules\Accounting\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;
use Illuminate\Validation\Rule;

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

        if (in_array($this->method(), ['PUT', 'PATCH'])) {
            $rules['code'] = [
                'required',
                'max:255',
                Rule::unique('acc_account_heads', 'code')->ignore($this->id),
            ];
        }

        return $rules;
    }

}
