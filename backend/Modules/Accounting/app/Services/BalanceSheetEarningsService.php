<?php

namespace Modules\Accounting\Services;

use Illuminate\Support\Collection;
use Modules\Accounting\Models\AccountHead;

class BalanceSheetEarningsService
{
    public function accountPath(Collection $heads): array
    {
        $account = $heads->firstWhere('system_key', AccountHead::INCOME_OVER_EXPENDITURE_KEY);
        $path = [];
        $visited = [];
        while ($account) {
            if (isset($visited[$account->id])) {
                return [];
            }
            $visited[$account->id] = true;
            array_unshift($path, $account);
            if (!$account->parent_id) {
                break;
            }
            $account = $heads->get($account->parent_id);
            if (!$account) {
                return [];
            }
        }

        return count($path) >= 2 && count($path) <= 5
            && $path[0]->code === AccountHead::MAIN_CODES['equity_liability']
            ? $path : [];
    }

    public function reconcile(array $tree, Collection $heads, array $path, array $totalsByLevel, int $maxDepth): array
    {
        $income = $expense = 0;
        foreach ($heads as $head) {
            if ($head->parent_id || !in_array($head->type, ['income', 'expense'], true)) {
                continue;
            }
            $totals = $totalsByLevel[0]->get($head->id);
            $debit = $this->cents($totals->total_debit ?? 0);
            $credit = $this->cents($totals->total_credit ?? 0);
            if ($head->type === 'income') {
                $income += $credit - $debit;
            } else {
                $expense += $debit - $credit;
            }
        }

        // Closing journals reduce the remaining income/expense balances. Only this
        // unclosed net amount is added; amounts already posted to equity stay intact.
        $unclosed = $income - $expense;
        $target = $path ? $path[count($path) - 1] : null;
        $postedRow = $target ? $totalsByLevel[count($path) - 1]->get($target->id) : null;
        $posted = $this->cents($postedRow->total_credit ?? 0) - $this->cents($postedRow->total_debit ?? 0);
        $summary = [
            'system_key' => AccountHead::INCOME_OVER_EXPENDITURE_KEY,
            'configured' => $target !== null,
            'account_id' => $target?->id,
            'account_name' => $target?->name,
            'account_code' => $target?->code,
            'income_balance' => $income / 100,
            'expense_balance' => $expense / 100,
            'unclosed_balance' => $unclosed / 100,
            'posted_balance' => $target ? $posted / 100 : null,
            'reported_balance' => $target ? ($posted + $unclosed) / 100 : null,
        ];

        if ($target) {
            $pathIds = array_map(fn ($account) => $account->id, $path);
            $this->applyAdjustment($tree, $pathIds, $summary, $unclosed, $maxDepth);
        }

        return ['coa' => $tree, 'income_over_expenditure' => $summary];
    }

    private function applyAdjustment(array &$accounts, array $pathIds, array $summary, int $unclosed, int $maxDepth, int $depth = 0): void
    {
        foreach ($accounts as &$account) {
            if (!in_array($account['id'], $pathIds, true)) {
                continue;
            }
            $debit = $this->cents($account['total_debit']) + max(0, -$unclosed);
            $credit = $this->cents($account['total_credit']) + max(0, $unclosed);
            $account['total_debit'] = $debit / 100;
            $account['total_credit'] = $credit / 100;
            $account['balance'] = ($account['is_debit'] ? $debit - $credit : $credit - $debit) / 100;

            if ($account['id'] === $summary['account_id']) {
                $account['earnings'] = $summary;
                if ($unclosed !== 0 && $depth < $maxDepth) {
                    // A report-only line makes the subaccount breakdown reconcile.
                    // No journal entry or account balance is created or changed.
                    $account['children'][] = [
                        'id' => 'income-over-expenditure-unclosed',
                        'code' => '',
                        'name' => 'Unclosed income over expenditure (calculated)',
                        'parent_id' => $account['id'],
                        'type' => $account['type'],
                        'root_type' => $account['root_type'],
                        'is_debit' => false,
                        'is_report_adjustment' => true,
                        'total_debit' => max(0, -$unclosed) / 100,
                        'total_credit' => max(0, $unclosed) / 100,
                        'balance' => $unclosed / 100,
                        'children' => [],
                    ];
                }
            } else {
                $this->applyAdjustment($account['children'], $pathIds, $summary, $unclosed, $maxDepth, $depth + 1);
            }
        }
    }

    private function cents($amount): int
    {
        return (int) round((float) $amount * 100);
    }
}
