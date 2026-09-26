<?php

namespace Modules\Accounting\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Modules\Accounting\Models\AccountHead;
use Modules\Core\Http\Controllers\Api\BaseApiController;

class LedgerReportController extends BaseApiController
{
    public function accounts()
    {
        return $this->listItems(DB::table('acc_account_heads')->orderBy('code')->get(['id', 'parent_id', 'code', 'name']), 'Ledger account filters fetched successfully.');
    }

    public function index(Request $request)
    {
        $levels = ['account_type_id', 'account_category_id', 'control_group_id', 'ledger_group_id', 'ledger_account_id'];
        $rules = [
            'start_date' => ['required', 'date_format:Y-m-d'],
            'end_date' => ['required', 'date_format:Y-m-d', 'after_or_equal:start_date'],
            'branch_id' => ['nullable', 'integer', 'min:0'],
        ];
        foreach ($levels as $level) $rules[$level] = [in_array($level, ['ledger_group_id', 'ledger_account_id'], true) ? 'nullable' : 'required', 'integer', 'exists:acc_account_heads,id'];
        $data = $request->validate($rules);
        $accounts = AccountHead::query()->whereIn('id', array_filter(array_intersect_key($data, array_flip($levels))))->get()->keyBy('id');
        $parentId = null; $selected = [];
        foreach ($levels as $level) {
            if (empty($data[$level])) continue;
            $head = $accounts[$data[$level]];
            if (($head->parent_id === null ? null : (int) $head->parent_id) !== $parentId) {
                throw ValidationException::withMessages([$level => 'Select an account belonging to the selected parent.']);
            }
            $parentId = (int) $head->id;
            $selected[$level] = ['id' => $head->id, 'code' => $head->code, 'name' => $head->name];
        }
        $branch = (int) ($data['branch_id'] ?? 0);
        $query = DB::table('acc_journal_entry_details as detail')
            ->join('acc_journal_entries as journal', 'journal.id', '=', 'detail.journal_entry_id')
            ->whereIn('journal.status', ['pending', 'approved'])
            ->when($branch, fn ($q) => $q->where('journal.branch_id', $branch));
        foreach ($levels as $level) {
            if (!empty($data[$level])) $query->where('detail.'.$level, $data[$level]);
        }
        $opening = (clone $query)->whereDate('journal.date', '<', $data['start_date'])
            ->selectRaw('COALESCE(SUM(detail.debit - detail.credit), 0) as balance')->first();
        $openingCents = (int) round((float) $opening->balance * 100);
        $balance = $openingCents; $debitTotal = 0; $creditTotal = 0;
        $entries = $query->leftJoin('acc_account_heads as head', 'head.id', '=', 'detail.ledger_account_id')
            ->whereDate('journal.date', '>=', $data['start_date'])->whereDate('journal.date', '<=', $data['end_date'])
            ->orderBy('journal.date')->orderBy('journal.id')->orderBy('detail.id')
            ->get(['detail.id', 'journal.id as journal_id', 'journal.date', 'journal.voucher_type', 'journal.voucher_no', 'journal.reference', 'journal.narration', 'journal.branch_id', 'detail.remarks', 'detail.debit', 'detail.credit', 'head.code as account_code', 'head.name as account_name']);
        $rows = [];
        foreach ($entries as $entry) {
            $remarks = trim((string) $entry->remarks);
            $narration = trim((string) $entry->narration);
            $debit = (int) round((float) $entry->debit * 100);
            $credit = (int) round((float) $entry->credit * 100);
            $debitTotal += $debit; $creditTotal += $credit; $balance += $debit - $credit;
            $rows[] = [
                'id' => $entry->id, 'journal_id' => $entry->journal_id, 'date' => substr($entry->date, 0, 10),
                'account_code' => $entry->account_code, 'account_name' => $entry->account_name,
                'particulars' => $remarks !== '' ? $remarks : $narration,
                'voucher_no' => $entry->voucher_no ?? '', 'voucher_type' => $entry->voucher_type,
                'reference' => $entry->reference, 'branch_id' => $entry->branch_id,
                'debit' => $debit / 100, 'credit' => $credit / 100, 'balance' => $balance / 100,
            ];
        }
        return $this->listItems([
            'start_date' => $data['start_date'], 'end_date' => $data['end_date'], 'branch_id' => $branch,
            'accounts' => $selected, 'opening_balance' => $openingCents / 100, 'rows' => $rows,
            'totals' => ['debit' => $debitTotal / 100, 'credit' => $creditTotal / 100, 'balance' => $balance / 100],
        ], 'Ledger Report fetched successfully.');
    }
}
