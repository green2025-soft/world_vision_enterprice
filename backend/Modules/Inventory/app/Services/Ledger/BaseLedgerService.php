<?php

namespace Modules\Inventory\Services\Ledger;

use Illuminate\Support\Facades\DB;

abstract class BaseLedgerService
{
    

    abstract protected function modelClass(): string;
    abstract protected function relationKey(): string;

    /**
     * CREATE / UPDATE
     */
    protected function storeOrUpdate(array $data)
    {
        return DB::transaction(function () use ($data) {

            $amount = (float) ($data['amount'] ?? 0);

            $debit  = ($data['direction'] ?? null) === 'in' ? $amount : 0;
            $credit = ($data['direction'] ?? null) === 'out' ? $amount : 0;

            // 2. recalculate AFTER clean state
            $lastBalance = $this->getLastBalance($data);

            $balance = $lastBalance + $debit - $credit;
            
            $payload = array_merge($data, [
                $this->relationKey() => $data[$this->relationKey()],
                'transaction_type'   => $data['type'],
                'debit'              => $debit,
                'credit'             => $credit,
                'balance'            => $balance,

                'date'         => $data['date'] ?? now(),
                'reference_id' => $data['reference_id'] ?? null,
                'reference_no' => $data['reference_no'] ?? null,
                'note'         => $data['note'] ?? null,
                'branch_id'    => $data['branch_id'] ?? null,
            ]);

            return $this->modelClass()::create($payload);
        });
    }

    /**
     * DELETE
     */
    public function delete(array $data): void
    {
        $this->modelClass()::where($this->relationKey(), $data[$this->relationKey()])
            ->when(!empty($data['reference_id']), function ($q) use ($data) {
                $q->where('reference_id', $data['reference_id']);
            })
            ->delete();
    }

    public function existingDelete(array $data): void
    {
        if (isset($data[0])){
            foreach ($data as $item) {
                $this->delete($item);
            }
        }else{
            $this->delete($data);
        }

    }



    /**
     * 🔥 CLEAN BALANCE (FIXED)
     */
    protected function getLastBalance(array $data): float
    {
        $key = $this->relationKey();

        return (float) $this->modelClass()::where($key, $data[$key])
            ->where('branch_id', $data['branch_id'] ?? null)
            ->sum(DB::raw('debit - credit'));
    }

   public function generateReferenceNo(string $prefix = '', int $digit = 6): string
    {
        return DB::transaction(function () use ($prefix, $digit) {

            // lock latest row (avoid duplicate in concurrent request)
            $last = $this->modelClass()::query()
                ->select('reference_no')
                ->whereNotNull('reference_no')
                ->lockForUpdate()
                ->latest('id')
                ->first();

            $nextNumber = 1;

            if ($last && $last->reference_no) {
                $number = (int) preg_replace('/\D/', '', $last->reference_no);
                $nextNumber = $number + 1;
            }

            return $prefix . str_pad($nextNumber, $digit, '0', STR_PAD_LEFT);
        });
    }
}