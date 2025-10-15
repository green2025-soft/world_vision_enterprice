<?php

namespace Modules\Inventory\Services;

use Illuminate\Support\Facades\DB;
use Modules\Accounting\Services\AccountingManagerService;

abstract class BasePartyAccountingService
{
    protected $accountingService;
    protected string $ledgerModel;
    protected string $partyKey;       // 'supplier_id' / 'customer_id'
    protected string $modulePrefix;   // e.g. 'Supplier', 'Customer'

    public function __construct()
    {
        $this->accountingService = app(AccountingManagerService::class);
    }

    public function recordTransaction(array $data, string $type)
    {
        return DB::transaction(function () use ($data, $type) {
            $amount = floatval($data['amount']);
            $partyId = $data[$this->partyKey];
            $lastBalance = $this->getLastBalance($partyId);

            [$debit, $credit, $newBalance] = $this->calculateAmounts($type, $amount, $lastBalance);

            if ($amount > 0) {
                $this->createLedgerEntry([
                    $this->partyKey      => $partyId,
                    'transaction_type'   => $type,
                    'debit'              => $debit,
                    'credit'             => $credit,
                    'balance'            => $newBalance,
                    'date'               => $data['date'] ?? now(),
                    'reference_id'       => $data['reference_id'] ?? null,
                    'reference_no'       => $data['reference_no'] ?? null,
                    'note'               => $data['note'] ?? null,
                    'branch_id'          => $data['branch_id'] ?? null,
                ]);
            }

            // ✅ Accounting Entry
            $meta = $this->getAccountingMetaForType($type);
            

            $this->accountingService->createEntryFromModule(
                moduleName: $meta['module'],
                sourceType: $meta['source'],
                sourceId:   $data['reference_id'] ?? null,
                data:       array_merge($data, ['amount' => $amount])
            );
        });
    }

    public function deleteEntry(int $sourceId, string $type): void
    {
        $this->ledgerModel::where('transaction_type', $type)
            ->where('reference_id', $sourceId)
            ->delete();

        $meta = $this->getAccountingMetaForType($type);

        $this->accountingService->deleteEntryFromModule(
            moduleName: $meta['module'],
            sourceType: $meta['source'],
            sourceId: $sourceId
        );
    }

    protected function getLastBalance(int $partyId): float
    {
        return $this->ledgerModel::where($this->partyKey, $partyId)
                ->latest('id')
                ->value('balance') ?? 0;
    }

    protected function createLedgerEntry(array $data)
    {
        return $this->ledgerModel::create($data);
    }

    protected function calculateAmounts(string $type, float $amount, float $lastBalance): array
    {
        return match ($type) {
            'advance', 'return'                 => [$amount, 0, $lastBalance + $amount],
            'payment', 'purchase', 'sale'       => [0, $amount, $lastBalance - $amount],
            'adjustment'                        => [0, $amount, $lastBalance - $amount],
            'opening_balance', 'previous_due'   => [0, $amount, $lastBalance + $amount],
            default                             => throw new \InvalidArgumentException("Invalid transaction type: $type"),
        };
    }

    abstract protected function getAccountingMetaForType(string $type): array;
}
