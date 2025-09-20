<?php

namespace Modules\Accounting\Http\Requests;

use Modules\Core\Http\Requests\BaseRequest;
use Illuminate\Validation\Rule;
class JournalEntryRequest extends BaseRequest
{

    protected array $rules = [
        'date'                  => 'required|date',
        'voucher_type'          => 'required|string|max:50',
        'reference'             => ['required', 'string', 'max:255', 'unique:acc_journal_entries,reference'],
        'narration'             => 'nullable|string',

        'lines'                         => 'required|array|min:2',
        'lines.*.account_head_id'       => 'required|exists:acc_account_heads,id',
        'lines.*.debit'                 => 'required_without:lines.*.credit|numeric|min:0',
        'lines.*.credit'                => 'required_without:lines.*.debit|numeric|min:0',
    ];

    public function rules(): array
    {
        $rules = $this->rules;

        // If update request, override unique rule
        if (in_array($this->method(), ['PUT', 'PATCH'])) {
            $rules['reference'] = [
                'required',
                'string',
                'max:255',
                Rule::unique('acc_journal_entries', 'reference')->ignore($this->route('journal_entry') ?? $this->id),
            ];
        }

        return $rules;
    }

    
    public function withValidator($validator)
    {
        $validator->after(function ($validator) {
            $debitTotal = 0;
            $creditTotal = 0;

            foreach ($this->input('lines', []) as $line) {
                $debitTotal += floatval($line['debit'] ?? 0);
                $creditTotal += floatval($line['credit'] ?? 0);
            }

            if (round($debitTotal, 2) !== round($creditTotal, 2)) {
                $validator->errors()->add('lines', 'Total debit and credit must be equal.');
            }
        });
    }

    public function messages(): array
    {
        return [
            'lines.required'                    => 'At least two journal lines are required.',
            'lines.*.account_head_id.required'  => 'Each line must have a valid account head.',
            'lines.*.debit.required_without'    => 'Either debit or credit must be provided.',
            'lines.*.credit.required_without'   => 'Either debit or credit must be provided.',
        ];
    }
}
