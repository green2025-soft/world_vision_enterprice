<?php

namespace Modules\Accounting\Models;

use Modules\Core\Models\User;

class AccountBalance extends AccBaseModel
{
    protected $fillable = [
        'account_head_id', 'debit', 'credit', 'balance', 'as_of_date', 'branch_id'
    ];

     protected $casts = [
        'debit' => 'float',
        'credit' => 'float',
        'balance' => 'float',
        'as_of_date' => 'date',
    ];

 

      /**
     * Update or create balance for a given account head and date
     */
   public static function updateBalance(int $accountHeadId, float $debit = 0, float $credit = 0, string $asOfDate = null, int $branchId = null): ?self
{
    $asOfDate = $asOfDate ?? now()->toDateString();
    $accountHead = AccountHead::findOrFail($accountHeadId);
    $accountType = strtolower($accountHead->type);


    $balance = self::firstOrNew([
        'account_head_id' => $accountHeadId,
        'as_of_date' => $asOfDate,
    ]);

 
    $previousBalanceRecord = self::where('account_head_id', $accountHeadId)
                                ->where('as_of_date', '<', $asOfDate)
                                ->orderByDesc('as_of_date')
                                ->first();

    $previousBalance = $previousBalanceRecord ? $previousBalanceRecord->balance : 0;


    $balance->debit = ($balance->debit ?? 0) + $debit;
    $balance->credit = ($balance->credit ?? 0) + $credit;


    $adjustment = match ($accountType) {
        'asset', 'expense' => $balance->debit - $balance->credit,
        'liability', 'equity', 'income' => $balance->credit - $balance->debit,
        default => 0,
    };

    $balance->balance = $previousBalance + $adjustment;

    if (!is_null($branchId)) {
        $balance->branch_id = $branchId;
    }

 
    if (
        round($balance->debit, 2) === 0.00 &&
        round($balance->credit, 2) === 0.00 &&
        round($balance->balance, 2) === 0.00
    ) {
        if ($balance->exists) {
            $balance->delete();
        }
        return null;
    }

    $balance->save();


    self::updateSubsequentBalances($accountHeadId, $asOfDate, $accountType);

    return $balance;
}


protected static function updateSubsequentBalances(int $accountHeadId, string $fromDate, string $accountType): void
{
    $balances = self::where('account_head_id', $accountHeadId)
                    ->where('as_of_date', '>', $fromDate)
                    ->orderBy('as_of_date')
                    ->get();

    $previousBalanceRecord = self::where('account_head_id', $accountHeadId)
                                ->where('as_of_date', '<=', $fromDate)
                                ->orderByDesc('as_of_date')
                                ->first();

    $previousBalance = $previousBalanceRecord ? $previousBalanceRecord->balance : 0;

    foreach ($balances as $balance) {
        $adjustment = match ($accountType) {
            'asset', 'expense' => $balance->debit - $balance->credit,
            'liability', 'equity', 'income' => $balance->credit - $balance->debit,
            default => 0,
        };

        $balance->balance = $previousBalance + $adjustment;
        $balance->save();

        $previousBalance = $balance->balance;
    }
}




    public function accountHead()
    {
        return $this->belongsTo(AccountHead::class, 'account_head_id');
    }




}
