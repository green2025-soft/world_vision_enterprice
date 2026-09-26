<?php

namespace Modules\Accounting\Http\Controllers\Api;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Modules\Accounting\Models\AccountHead;
use Modules\Core\Http\Controllers\Api\BaseApiController;

class ChangesInEquityController extends BaseApiController
{
    public function index(Request $request)
    {
        $data = $request->validate([
            'month' => ['required', 'date_format:Y-m'], 'branch_id' => ['nullable', 'integer', 'min:0'],
            'depth' => ['sometimes', 'integer', 'between:1,4'],
        ]);
        $month = Carbon::createFromFormat('!Y-m', $data['month']);
        $previous = $month->copy()->subMonth();
        $year = $month->month >= 7 ? $month->year : $month->year - 1;
        $fy = Carbon::create($year, 7, 1)->startOfDay();
        $periods = [
            ['key' => 'current', 'label' => 'Up-to '.$month->format('M-y'), 'start_date' => $month->toDateString(), 'end_date' => $month->copy()->endOfMonth()->toDateString()],
            ['key' => 'previous', 'label' => 'Up-to last month '.$previous->format('M-y'), 'start_date' => $previous->toDateString(), 'end_date' => $previous->copy()->endOfMonth()->toDateString()],
            ['key' => 'fiscal', 'label' => sprintf('FY %d-%02d', $year, ($year + 1) % 100), 'start_date' => $fy->toDateString(), 'end_date' => $month->copy()->endOfMonth()->toDateString()],
            ['key' => 'previous_fiscal', 'label' => sprintf('FY %d-%02d', $year - 1, $year % 100), 'start_date' => $fy->copy()->subYear()->toDateString(), 'end_date' => $fy->copy()->subDay()->toDateString()],
        ];
        $heads = AccountHead::query()->orderBy('code')->get(['id', 'parent_id', 'code', 'name', 'system_key'])->keyBy('id');
        $fund = $heads->firstWhere('system_key', 'equity_funds');
        $earnings = $heads->firstWhere('system_key', AccountHead::INCOME_OVER_EXPENDITURE_KEY);
        $paths = [];
        foreach ($heads as $head) {
            $path = []; $seen = []; $current = $head;
            while ($current) {
                if (isset($seen[$current->id])) throw ValidationException::withMessages(['accounts' => 'Circular account hierarchy.']);
                $seen[$current->id] = true;
                array_unshift($path, $current->id);
                $current = $heads->get($current->parent_id);
            }
            $paths[$head->id] = $path;
        }
        if (!$fund || !$earnings || !in_array($fund->id, $paths[$earnings->id], true)
            || (int) $heads[$paths[$fund->id][0]]->code !== 200000) {
            throw ValidationException::withMessages(['accounts' => 'Assign the Equity / Funds report role to the funds group containing Income over expenditure, excluding liabilities.']);
        }
        $branch = (int) ($data['branch_id'] ?? 0);
        $depth = (int) ($data['depth'] ?? 2);
        $account = 'COALESCE(ledger_account_id, ledger_group_id, control_group_id, account_category_id, account_type_id)';
        $base = DB::table('acc_journal_entry_details as detail')->join('acc_journal_entries as journal', 'journal.id', '=', 'detail.journal_entry_id')
            ->whereIn('journal.status', ['pending', 'approved'])->when($branch, fn ($q) => $q->where('journal.branch_id', $branch));
        $rows = []; $opening = []; $closing = [];
        foreach ($periods as $period) {
            $key = $period['key'];
            $totals = (clone $base)->whereDate('journal.date', '<=', $period['end_date'])->selectRaw("$account as head_id")
                ->selectRaw('SUM(CASE WHEN journal.date < ? THEN detail.credit - detail.debit ELSE 0 END) as opening', [$period['start_date']])
                ->selectRaw('SUM(CASE WHEN journal.date >= ? THEN detail.credit - detail.debit ELSE 0 END) as movement', [$period['start_date']])
                ->groupByRaw($account)->get();
            $openingCents = 0; $movementCents = 0; $unclosedMovement = 0;
            foreach ($totals as $total) {
                $path = $paths[$total->head_id] ?? [];
                if (!$path) continue;
                $isFunds = in_array($fund->id, $path, true);
                $isOperating = in_array((int) $heads[$path[0]]->code, [300000, 400000], true);
                if (!$isFunds && !$isOperating) continue;
                $before = (int) round((float) $total->opening * 100);
                $change = (int) round((float) $total->movement * 100);
                $openingCents += $before; $movementCents += $change;
                if ($isOperating) { $unclosedMovement += $change; continue; }
                $id = $path[min($depth, count($path) - 1)];
                $rows[$id] ??= ['id' => $id, 'code' => $heads[$id]->code, 'name' => $heads[$id]->name, 'amounts' => []];
                $rows[$id]['amounts'][$key] = ($rows[$id]['amounts'][$key] ?? 0) + $change;
            }
            $rows['unclosed'] ??= ['id' => 'unclosed', 'code' => '', 'name' => 'Change in unclosed income over expenditure', 'amounts' => []];
            $rows['unclosed']['amounts'][$key] = $unclosedMovement;
            $opening[$key] = $openingCents / 100;
            $closing[$key] = ($openingCents + $movementCents) / 100;
        }
        foreach ($rows as &$row) {
            foreach ($periods as $period) $row['amounts'][$period['key']] = ($row['amounts'][$period['key']] ?? 0) / 100;
        }
        unset($row);
        usort($rows, fn ($a, $b) => ($a['id'] === 'unclosed' ? 1 : 0) <=> ($b['id'] === 'unclosed' ? 1 : 0) ?: strnatcmp((string) $a['code'], (string) $b['code']));
        return $this->listItems([
            'month' => $month->endOfMonth()->toDateString(), 'branch_id' => $branch, 'periods' => $periods,
            'opening' => $opening, 'rows' => array_values($rows), 'closing' => $closing,
        ], 'Changes in Equity fetched successfully.');
    }
}
