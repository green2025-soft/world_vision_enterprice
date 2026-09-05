<?php

namespace Modules\Inventory\Services\Ledger;

use Illuminate\Database\Eloquent\Builder;

class PartyBalanceService
{
    public function getBalances( Builder $query,string $ledgerModel,string $partyKey, int $branchId, ?int $partyId = null){
        $query->where('branch_id', $branchId)
        ->when($partyId,
        fn ($query) => $query->where('id', $partyId),
        fn ($query) => $query->where('status', 1)
        );
        $parties = $query->smartPaginate();
        $partyIds = $parties->pluck('id')->toArray();
        $balances = $ledgerModel::query()
        ->whereIn($partyKey, $partyIds)
         ->where('branch_id', $branchId)
         ->selectRaw("{$partyKey}, SUM(debit - credit) as balance")
         ->groupBy($partyKey)->get()
         ->keyBy($partyKey);
          $parties->getCollection()->transform(
            function ($party) use ($balances, $partyKey) {
                $party->balance = $balances[$party->id]->balance ?? 0;
                return $party;
            }
        );

        return $parties;
    }

    public function getDueList(Builder $query,string $partyKey, int $branchId, ?int $partyId = null){
           return $query->where('branch_id', $branchId)
           ->where('status', 1)
           ->when($partyId, fn ($query) => $query->where('id', $partyId) )
            ->withSum([
            'ledgers as debit_total' => function ($query) use ($branchId) {
                $query->where('branch_id', $branchId);
            }
        ], 'debit')
        ->withSum([
            'ledgers as credit_total' => function ($query) use ($branchId) {
                $query->where('branch_id', $branchId);
            }
        ], 'credit')
        ->smartPaginate();

    }
}