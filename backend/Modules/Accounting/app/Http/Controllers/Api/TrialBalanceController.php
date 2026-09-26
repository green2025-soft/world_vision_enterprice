<?php

namespace Modules\Accounting\Http\Controllers\Api;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Modules\Accounting\Models\AccountHead;
use Modules\Accounting\Models\JournalEntryDetail;
use Modules\Core\Http\Controllers\Api\BaseApiController;

class TrialBalanceController extends BaseApiController
{
    public function index(Request $request)
    {
        $data = $request->validate([
            'month' => ['required', 'date_format:Y-m'],
            'branch_id' => ['nullable', 'integer', 'min:0'],
            'depth' => ['sometimes', 'integer', 'between:1,4'],
        ]);
        $start = Carbon::createFromFormat('!Y-m', $data['month'])->toDateString();
        $end = Carbon::parse($start)->endOfMonth()->toDateString();
        $branch = (int) ($data['branch_id'] ?? 0);
        $depth = (int) ($data['depth'] ?? 4);
        // Aggregate at the posting account before splitting debit/credit balances.
        // Parent totals sum those balances without netting unrelated accounts together.
        $account = 'COALESCE(ledger_account_id, ledger_group_id, control_group_id, account_category_id, account_type_id)';
        $totals = JournalEntryDetail::query()
            ->join('acc_journal_entries as journal', 'journal.id', '=', 'acc_journal_entry_details.journal_entry_id')
            ->whereIn('journal.status', ['pending', 'approved'])
            ->whereDate('journal.date', '<=', $end)
            ->when($branch, fn ($query) => $query->where('journal.branch_id', $branch))
            ->selectRaw("$account as head_id")
            ->selectRaw('SUM(CASE WHEN journal.date < ? THEN acc_journal_entry_details.debit - acc_journal_entry_details.credit ELSE 0 END) as opening', [$start])
            ->selectRaw('SUM(CASE WHEN journal.date >= ? THEN acc_journal_entry_details.debit ELSE 0 END) as period_debit', [$start])
            ->selectRaw('SUM(CASE WHEN journal.date >= ? THEN acc_journal_entry_details.credit ELSE 0 END) as period_credit', [$start])
            ->groupByRaw($account)->get()->keyBy('head_id');
        $heads = AccountHead::query()->orderBy('code')->get(['id', 'parent_id', 'code', 'name']);
        $children = $heads->groupBy(fn ($head) => $head->parent_id ?? 'root');
        $fields = ['opening_debit', 'opening_credit', 'period_debit', 'period_credit', 'closing_debit', 'closing_credit'];
        $build = function ($head, $level, array $path = []) use (&$build, $children, $totals, $fields, $depth) {
            if (isset($path[$head->id])) {
                throw new \RuntimeException('Circular chart of accounts hierarchy.');
            }
            $path[$head->id] = true;
            $entry = $totals->get($head->id);
            $opening = (int) round((float) ($entry->opening ?? 0) * 100);
            $debit = (int) round((float) ($entry->period_debit ?? 0) * 100);
            $credit = (int) round((float) ($entry->period_credit ?? 0) * 100);
            $closing = $opening + $debit - $credit;
            $values = array_combine($fields, [max(0, $opening), max(0, -$opening), $debit, $credit, max(0, $closing), max(0, -$closing)]);
            $nodes = [];
            foreach ($children->get($head->id, collect()) as $child) {
                $node = $build($child, $level + 1, $path);
                foreach ($fields as $field) {
                    $values[$field] += (int) round($node[$field] * 100);
                }
                $nodes[] = $node;
            }
            return array_merge($head->attributesToArray(), array_map(fn ($value) => $value / 100, $values), [
                'children' => $level < $depth ? $nodes : [],
            ]);
        };
        $coa = $children->get('root', collect())->map(fn ($head) => $build($head, 0))->values()->all();
        $grand = [];
        foreach ($fields as $field) {
            $grand[$field] = array_sum(array_map(fn ($node) => (int) round($node[$field] * 100), $coa)) / 100;
        }
        return $this->listItems([
            'month' => $end, 'start_date' => $start, 'branch_id' => $branch,
            'coa' => $coa, 'totals' => $grand,
        ], 'Trial Balance fetched successfully.');
    }
}
