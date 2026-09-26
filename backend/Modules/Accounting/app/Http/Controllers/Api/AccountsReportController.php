<?php

namespace Modules\Accounting\Http\Controllers\Api;

use Modules\Core\Http\Controllers\Api\BaseApiController;
use Modules\Accounting\Models\AccountHead;
use Modules\Accounting\Models\JournalEntryDetail;
use Modules\Accounting\Services\BalanceSheetEarningsService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class AccountsReportController extends BaseApiController
{
    protected string $title = 'Chart Of Account';

    public function __construct()
    {
        $this->model = AccountHead::class;
    }

    public function index()
    {
        return $this->listItems(AccountHead::query()->get(), "{$this->title} list fetched successfully.");
    }

    private function sumByLevel(string $column, string $month, $branch_id, ?string $startDate = null)
    {
        return JournalEntryDetail::query()
            ->select(
                $column,
                DB::raw('SUM(debit)  as total_debit'),
                DB::raw('SUM(credit) as total_credit')
            )
            ->whereNotNull($column)
            ->whereHas('journalEntry', function ($q) use ($month, $branch_id, $startDate) {
                // Entries are saved as pending; both pending and approved affect this report.
                $q->whereIn('status', ['pending', 'approved'])
                  ->whereDate('date', '<=', $month);

                if ($startDate !== null) {
                    $q->whereDate('date', '>=', $startDate);
                }

                if ($branch_id && $branch_id != 0) {
                    $q->where('branch_id', $branch_id);
                }
            })
            ->groupBy($column)
            ->get()
            ->keyBy($column);
    }

    private function attachBalances(
        $accounts,
        array $totalsByLevel,
        int $depth = 0,
        ?string $rootType = null
    ): array {
        $result = [];
        $totals = $totalsByLevel[$depth] ?? collect();

        foreach ($accounts as $acc) {
            $row    = $totals[$acc->id] ?? null;
            $debit  = (float) ($row->total_debit  ?? 0);
            $credit = (float) ($row->total_credit ?? 0);
            $accountRootType = $rootType ?? $acc->type;

            // Serialize attributes only: the root_type accessor loads parent relations.
            $account = $acc->attributesToArray();
            $account['total_debit'] = $debit;
            $account['total_credit'] = $credit;
            $account['balance'] = round($acc->is_debit
                ? ($debit - $credit)
                : ($credit - $debit), 2);
            $account['root_type'] = $accountRootType;

            // Stop at the eager-loaded depth instead of lazily fetching every ledger.
            $account['children'] = $acc->relationLoaded('children')
                ? $this->attachBalances(
                    $acc->getRelation('children'),
                    $totalsByLevel,
                    $depth + 1,
                    $accountRootType
                )
                : [];

            $result[] = $account;
        }

        return $result;
    }

    public function incomeExpenditure(Request $request)
    {
        $validated = $request->validate([
            'month' => ['required', 'date_format:Y-m'],
            'branch_id' => ['nullable', 'integer', 'min:0'],
            'depth' => ['sometimes', 'integer', 'between:1,4'],
            'period' => ['sometimes', 'in:month,financial_year'],
        ]);
        $date = Carbon::createFromFormat('!Y-m', $validated['month']);
        $year = $date->month >= 7 ? $date->year : $date->year - 1;
        $period = $validated['period'] ?? 'financial_year';
        $startDate = $period === 'month' ? $date->toDateString() : sprintf('%04d-07-01', $year);
        $endDate = $date->endOfMonth()->toDateString();
        $branchId = (int) ($validated['branch_id'] ?? 0);
        $depth = (int) ($validated['depth'] ?? 2);
        $accounts = AccountHead::query()
            ->whereNull('parent_id')
            ->whereIn('code', [AccountHead::MAIN_CODES['income'], AccountHead::MAIN_CODES['expense']])
            ->withChildrenRecursiveShort($depth)->orderBy('code')->get();
        $columns = ['account_type_id', 'account_category_id', 'control_group_id', 'ledger_group_id', 'ledger_account_id'];
        $totals = [];
        foreach (array_slice($columns, 0, $depth + 1) as $column) {
            $totals[] = $this->sumByLevel($column, $endDate, $branchId, $startDate);
        }

        return $this->listItems([
            'month' => $endDate,
            'start_date' => $startDate,
            'period' => $period,
            'financial_year' => sprintf('FY %d-%02d', $year, ($year + 1) % 100),
            'branch_id' => $branchId,
            'coa' => $this->attachBalances($accounts, $totals),
        ], 'Income & Expenditure statement fetched successfully.');
    }

    public function balanceSheet(Request $request)
    {
        $validated = $request->validate([
            'month' => ['required', 'date_format:Y-m'],
            'branch_id' => ['nullable', 'integer', 'min:0'],
            'depth' => ['sometimes', 'integer', 'between:1,4'],
        ]);

        $month = Carbon::createFromFormat('!Y-m', $validated['month'])->endOfMonth()->toDateString();
        $branch_id = (int) ($validated['branch_id'] ?? 0);
        $depth = (int) ($validated['depth'] ?? 2);

        $coa_data = AccountHead::query()
            ->whereIn('code', [AccountHead::MAIN_CODES['asset'], AccountHead::MAIN_CODES['equity_liability']])
            ->withChildrenRecursiveShort($depth)
            ->orderBy('code')
            ->get();

        $columns = ['account_type_id', 'account_category_id', 'control_group_id', 'ledger_group_id', 'ledger_account_id'];
        $heads = AccountHead::query()->get(['id', 'parent_id', 'code', 'name', 'type', 'is_debit', 'system_key'])->keyBy('id');
        $earningsService = app(BalanceSheetEarningsService::class);
        $earningsPath = $earningsService->accountPath($heads);
        $totalsByLevel = [];
        foreach (array_slice($columns, 0, max($depth + 1, count($earningsPath))) as $column) {
            $totalsByLevel[] = $this->sumByLevel($column, $month, $branch_id);
        }
        $coa_data = $this->attachBalances($coa_data, $totalsByLevel);
        $reconciled = $earningsService->reconcile($coa_data, $heads, $earningsPath, $totalsByLevel, $depth);

        $returnData = [
            'month'     => $month,
            'branch_id' => $branch_id,
            'coa'       => $reconciled['coa'],
            'income_over_expenditure' => $reconciled['income_over_expenditure'],
        ];

        return $this->listItems($returnData, 'Balance Sheet fetched successfully.');
    }
}
