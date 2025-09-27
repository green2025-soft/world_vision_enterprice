<?php
namespace Modules\Inventory\Services;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\SupplierLedger;
use Modules\Accounting\Services\AccountingManagerService;

class SupplierAccountingService
{
    protected $accountingService;

    protected $moduleName;
    protected $sourceType;

    public function __construct($moduleName ='Supplier Advance', $sourceType='Supplier Advance')
    {
        $this->moduleName = $moduleName;
        $this->sourceType = $sourceType;
        $this->accountingService = app(AccountingManagerService::class);
    }

    public function recordTransaction(array $data, string $type)
    {
        return DB::transaction(function () use ($data, $type) {
            $amount = $data['amount'];
            $supplierId = $data['supplier_id'];
            $lastBalance = $this->getLastBalance($supplierId);

            // Determine debit/credit and new balance
            [$debit, $credit, $newBalance] = match ($type) {
                'advance', 'purchase_return'    => [$amount, 0, $lastBalance + $amount],
                'payment', 'purchase'           => [0, $amount, $lastBalance - $amount],
                'adjustment'                    => [0, $amount, $lastBalance - $amount],
                'opening_balance'               => [0, $amount, $lastBalance + $amount],
                default                         => throw new \InvalidArgumentException("Invalid transaction type: $type"),
            };
            if ($amount >0){
            // Create Ledger Entry
            $ledger = $this->createLedgerEntry([
                'supplier_id'      => $supplierId,
                'transaction_type' => $type,
                'debit'            => $debit,
                'credit'           => $credit,
                'balance'          => $newBalance,
                'date'             => $data['date'] ?? now(),
                'reference_id'     => $data['reference_id'] ?? null,
                'reference_no'     => $data['reference_no'] ?? null,
                'note'             => $data['note'] ?? null,
                'branch_id'        => $data['branch_id']??'',
            ]);
            }else{
                $ledger = $data;
            }
            

            // 🔁 Optional: Accounting Entry Create
            $this->accountingService->createEntryFromModule(
                    moduleName: $this->moduleName,
                    sourceType: $this->sourceType,
                    sourceId:  $data['reference_id'] ?? null,
                    data: array_merge($data, ['amount' => $amount])
                );

            return $ledger;
        });
    }

    protected function getLastBalance(int $supplierId): float
    {
        return SupplierLedger::where('supplier_id', $supplierId)
            ->latest('id')
            ->value('balance') ?? 0;
    }

    protected function createLedgerEntry(array $data): SupplierLedger
    {
        return SupplierLedger::create($data);
    }

    public function deleteEntry(int $sourceId, string $type): void
    {
        // ✅ 1. Delete Supplier Ledger Entry
        SupplierLedger::where('transaction_type', $type)
            ->where('reference_id', $sourceId) 
            ->delete();

        // ✅ 2. Delete Accounting Entry
        $this->accountingService->deleteEntryFromModule(
            moduleName: $this->moduleName,
            sourceType: $this->sourceType,
            sourceId: $sourceId
        );
    }
}
