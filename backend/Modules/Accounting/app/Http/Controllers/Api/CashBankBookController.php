<?php

namespace Modules\Accounting\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Modules\Accounting\Models\AccountHead;
use Modules\Core\Http\Controllers\Api\BaseApiController;

class CashBankBookController extends BaseApiController
{
    public function index(Request $request)
    {
        $data = $request->validate([
            'start_date' => ['required', 'date_format:Y-m-d'],
            'end_date' => ['required', 'date_format:Y-m-d', 'after_or_equal:start_date'],
            'branch_id' => ['nullable', 'integer', 'min:0'],
        ]);
        $heads = AccountHead::query()->get(['id', 'parent_id', 'code', 'name', 'system_key'])->keyBy('id');
        $kinds = [];
        foreach ($heads as $head) {
            $current = $head; $seen = []; $kind = null; $root = null;
            while ($current) {
                if (isset($seen[$current->id])) throw ValidationException::withMessages(['accounts' => 'Circular account hierarchy.']);
                $seen[$current->id] = true;
                if (in_array($current->system_key, ['cash_in_hand', 'cash_at_bank'], true)) {
                    $mapped = $current->system_key === 'cash_in_hand' ? 'cash' : 'bank';
                    if ($kind && $kind !== $mapped) throw ValidationException::withMessages(['accounts' => 'Cash and bank report roles must not overlap.']);
                    $kind = $mapped;
                }
                $root = $current;
                $current = $heads->get($current->parent_id);
            }
            if ($kind && (int) $root->code === 100000) $kinds[$head->id] = $kind;
        }
        if (!$kinds) throw ValidationException::withMessages(['accounts' => 'Assign Cash in hand and/or Cash at bank report roles in Chart of Accounts.']);
        $branch = (int) ($data['branch_id'] ?? 0);
        $account = 'COALESCE(detail.ledger_account_id, detail.ledger_group_id, detail.control_group_id, detail.account_category_id, detail.account_type_id)';
        $query = DB::table('acc_journal_entry_details as detail')->join('acc_journal_entries as journal', 'journal.id', '=', 'detail.journal_entry_id')
            ->whereIn('journal.status', ['pending', 'approved'])->whereIn(DB::raw($account), array_keys($kinds))
            ->when($branch, fn ($q) => $q->where('journal.branch_id', $branch));
        $opening = ['cash' => 0, 'bank' => 0];
        foreach ((clone $query)->whereDate('journal.date', '<', $data['start_date'])->selectRaw("$account as head_id, SUM(detail.debit - detail.credit) as balance")->groupByRaw($account)->get() as $entry) {
            $opening[$kinds[$entry->head_id]] += (int) round((float) $entry->balance * 100);
        }
        $balance = $opening; $rows = []; $debitTotal = 0; $creditTotal = 0;
        $entries = $query->whereDate('journal.date', '>=', $data['start_date'])->whereDate('journal.date', '<=', $data['end_date'])
            ->orderBy('journal.date')->orderBy('journal.id')->orderBy('detail.id')
            ->selectRaw("$account as head_id")
            ->addSelect(['detail.id', 'journal.id as journal_id', 'journal.date', 'journal.voucher_no', 'journal.voucher_type', 'journal.narration', 'detail.remarks', 'detail.debit', 'detail.credit'])->get();
        foreach ($entries as $entry) {
            $debit = (int) round((float) $entry->debit * 100); $credit = (int) round((float) $entry->credit * 100);
            $kind = $kinds[$entry->head_id];
            $balance[$kind] += $debit - $credit;
            $debitTotal += $debit; $creditTotal += $credit;
            $remarks = trim((string) $entry->remarks);
            $rows[] = [
                'id' => $entry->id, 'journal_id' => $entry->journal_id, 'date' => substr($entry->date, 0, 10),
                'kind' => $kind, 'account_code' => $heads[$entry->head_id]->code, 'account_name' => $heads[$entry->head_id]->name,
                'particulars' => $remarks !== '' ? $remarks : trim((string) $entry->narration),
                'voucher_no' => $entry->voucher_no ?? '', 'voucher_type' => $entry->voucher_type,
                'debit' => $debit / 100, 'credit' => $credit / 100, 'cash' => $balance['cash'] / 100, 'bank' => $balance['bank'] / 100,
            ];
        }
        return $this->listItems([
            'start_date' => $data['start_date'], 'end_date' => $data['end_date'], 'branch_id' => $branch,
            'opening' => array_map(fn ($value) => $value / 100, $opening), 'rows' => $rows,
            'closing' => array_map(fn ($value) => $value / 100, $balance),
            'totals' => ['debit' => $debitTotal / 100, 'credit' => $creditTotal / 100],
        ], 'Cash & Bank Book fetched successfully.');
    }
}
