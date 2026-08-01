<?php

namespace Modules\Inventory\Services;

   
class LedgerService {

      public function getLedger($model, array $filters)
    {
        $partyKey = $filters['party_key'];
        $partyId  = $filters['party_id'];
        $branchId = $filters['branch_id'];
        $fromDate = $filters['from_date'];
        $toDate   = $filters['to_date'];



        /*
        |--------------------------------------------------------------------------
        | Opening Balance
        |--------------------------------------------------------------------------
        */

        $openingBalance = $model::query()
        ->where($partyKey, $partyId)
        ->where('branch_id', $branchId)
        ->where(function ($q) use ($fromDate) {
            // Opening Balance 
            $q->where('transaction_type', 'opening_balance')
            ->orWhere(function ($q) use ($fromDate) {
                $q->where('transaction_type', '!=', 'opening_balance')
                    ->whereDate('date', '<', $fromDate);
            });

        })
        ->selectRaw("
            COALESCE(SUM(debit),0) as total_debit,
            COALESCE(SUM(credit),0) as total_credit
        ")
        ->first();


        $opening = $openingBalance->total_debit 
                 - $openingBalance->total_credit;

        /*
        |--------------------------------------------------------------------------
        | Ledger
        |--------------------------------------------------------------------------
        */

        $ledgers = $model::query()
            ->where($partyKey, $partyId)
            ->where('branch_id', $branchId)
            ->where('transaction_type', '!=', 'opening_balance')
            ->whereDate('date', '>=', $fromDate)
            ->whereDate('date', '<=', $toDate)
            ->orderBy('id', 'asc')
            ->get();

        /*
        |--------------------------------------------------------------------------
        | Running Balance
        |--------------------------------------------------------------------------
        */

        $balance = $opening;

        foreach ($ledgers as $ledger) {

            $balance += $ledger->debit;
            $balance -= $ledger->credit;
            $ledger->running_balance = $balance;
            $ledger->particular = ucwords(str_replace('_',' ',$ledger->transaction_type));
        }


        return [
            'openingBalance' => $opening ?? 0,
            'ledgers'        => $ledgers,
            'closingBalance' => $balance,
        ];
    }

}
