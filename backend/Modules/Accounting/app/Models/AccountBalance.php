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
        'as_of_date'      => $asOfDate,
    ]);

    // Add new debit and credit
    $balance->debit  = ($balance->debit ?? 0) + $debit;
    $balance->credit = ($balance->credit ?? 0) + $credit;

    // Calculate balance based on account type
    $balance->balance = match ($accountType) {
        'asset', 'expense' => $balance->debit - $balance->credit,
        'liability', 'equity', 'income' => $balance->credit - $balance->debit,
        default => 0,
    };

    // ⚠️ If everything is zero, don't save — just delete the row if it exists
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

    if (!is_null($branchId)) {
        $balance->branch_id = $branchId;
    }
    $balance->save();

    return $balance;
}


    public function accountHead()
    {
        return $this->belongsTo(AccountHead::class, 'account_head_id');
    }




}
