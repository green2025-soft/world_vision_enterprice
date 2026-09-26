<?php

namespace Modules\Accounting\Http\Controllers\Api;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Modules\Accounting\Models\AccountHead;
use Modules\Core\Http\Controllers\Api\BaseApiController;

class ReceiptsPaymentsController extends BaseApiController
{
    public function index(Request $request)
    {
        $data = $request->validate([
            'month' => ['required', 'date_format:Y-m'], 'branch_id' => ['nullable', 'integer', 'min:0'],
            'depth' => ['sometimes', 'integer', 'between:1,4'],
        ]);
        $date = Carbon::createFromFormat('!Y-m', $data['month']);
        $start = $date->toDateString();
        $year = $date->month >= 7 ? $date->year : $date->year - 1;
        $fyStart = sprintf('%04d-07-01', $year);
        $end = $date->endOfMonth()->toDateString();
        $branch = (int) ($data['branch_id'] ?? 0);
        $depth = (int) ($data['depth'] ?? 2);
        $heads = AccountHead::query()->orderBy('code')->get(['id', 'parent_id', 'name', 'code', 'system_key'])->keyBy('id');
        $paths = [];
        $cashRoles = [];
        foreach ($heads as $head) {
            $path = []; $seen = []; $current = $head;
            while ($current) {
                if (isset($seen[$current->id])) {
                    throw new \RuntimeException('Circular chart of accounts hierarchy.');
                }
                $seen[$current->id] = true;
                array_unshift($path, $current);
                $current = $heads->get($current->parent_id);
            }
            $paths[$head->id] = $path;
            foreach ($path as $ancestor) {
                if (in_array($ancestor->system_key, ['cash_in_hand', 'cash_at_bank'], true) && (int) $path[0]->code === 100000) {
                    $cashRoles[$head->id] = $ancestor;
                    break;
                }
            }
        }
        if (!$cashRoles) {
            return response()->json(['status' => false, 'message' => 'Assign Cash in hand and/or Cash at bank report roles in Chart of Accounts before generating this report.'], 422);
        }
        $accountSql = 'COALESCE(ledger_account_id, ledger_group_id, control_group_id, account_category_id, account_type_id)';
        // Read actual journal lines: no profit adjustments or non-cash vouchers are added.
        $entries = DB::table('acc_journal_entry_details as detail')
            ->join('acc_journal_entries as journal', 'journal.id', '=', 'detail.journal_entry_id')
            ->whereIn('journal.status', ['pending', 'approved'])->whereDate('journal.date', '<=', $end)
            ->when($branch, fn ($query) => $query->where('journal.branch_id', $branch))
            ->selectRaw("$accountSql as head_id, journal.id as journal_id, journal.date, journal.voucher_type, detail.debit, detail.credit")
            ->orderBy('journal.id')->get()->groupBy('journal_id');
        $calculate = function (string $from) use ($entries, $cashRoles, $heads, $paths, $depth) {
            $groups = ['opening' => [], 'receipts' => [], 'payments' => [], 'closing' => []];
            $add = function ($group, $id, $code, $name, $cents) use (&$groups) {
                $groups[$group][$id] ??= ['id' => $id, 'code' => $code, 'name' => $name, 'cents' => 0];
                $groups[$group][$id]['cents'] += $cents;
            };
            foreach ($cashRoles as $id => $role) {
                $head = $depth === 4 ? $heads[$id] : $role;
                // At ledger detail, omit empty grouping accounts that only contain descendants.
                if ($depth === 4 && $heads->contains(fn ($other) => $other->parent_id === $id)) continue;
                foreach (['opening', 'closing'] as $group) $add($group, $head->id, $head->code, $head->name, 0);
            }
            foreach ($entries as $journalId => $lines) {
                $cashNet = 0; $counterparts = [];
                $inPeriod = substr($lines[0]->date, 0, 10) >= $from;
                foreach ($lines as $line) {
                    $net = (int) round((float) $line->debit * 100) - (int) round((float) $line->credit * 100);
                    if (isset($cashRoles[$line->head_id])) {
                        $head = $depth === 4 ? $heads[$line->head_id] : $cashRoles[$line->head_id];
                        $add('closing', $head->id, $head->code, $head->name, $net);
                        if (!$inPeriod) $add('opening', $head->id, $head->code, $head->name, $net);
                        $cashNet += $net;
                    } else {
                        $counterparts[$line->head_id] = ($counterparts[$line->head_id] ?? 0) - $net;
                    }
                }
                if (!$inPeriod || !$cashNet) continue; // Cash/bank transfers and non-cash entries have no external cash movement.
                $isReceipt = $cashNet > 0;
                $side = $isReceipt ? 'receipts' : 'payments';
                $counterparts = array_filter($counterparts);
                if (array_sum($counterparts) !== $cashNet) {
                    throw \Illuminate\Validation\ValidationException::withMessages(['journal' => 'Journal #'.$journalId.' is not balanced. Correct it before generating Receipts & Payments.']);
                }
                foreach ($counterparts as $id => $value) {
                    if (!isset($paths[$id])) {
                        throw \Illuminate\Validation\ValidationException::withMessages(['journal' => 'Journal #'.$journalId.' references a missing account.']);
                    }
                    $path = $paths[$id];
                    $head = $path[min($depth, count($path) - 1)];
                    // Show actual COA counterparts. Opposite-side entries are deductions
                    // within the cash-flow side, so compound vouchers reconcile to cash.
                    $add($side, $head->id, $head->code, $head->name, $isReceipt ? $value : -$value);
                }
            }
            $totals = [];
            foreach ($groups as $key => &$rows) {
                $totals[$key] = array_sum(array_column($rows, 'cents')) / 100;
                $rows = array_values(array_map(fn ($row) => ['id' => $row['id'], 'code' => $row['code'], 'name' => $row['name'], 'amount' => $row['cents'] / 100], $rows));
                usort($rows, fn ($a, $b) => strnatcmp((string) $a['code'], (string) $b['code']));
            }
            unset($rows);
            $totals['total_receipts'] = round($totals['opening'] + $totals['receipts'], 2);
            $totals['total_payments'] = round($totals['payments'] + $totals['closing'], 2);
            return ['groups' => $groups, 'totals' => $totals];
        };
        return $this->listItems([
            'month' => $end, 'start_date' => $start, 'fy_start_date' => $fyStart,
            'financial_year' => sprintf('FY %d-%02d', $year, ($year + 1) % 100),
            'branch_id' => $branch, 'depth' => $depth,
            'current' => $calculate($start), 'fiscal' => $calculate($fyStart),
        ], 'Receipts & Payments fetched successfully.');
    }
}
