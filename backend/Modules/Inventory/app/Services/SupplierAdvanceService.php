<?php

namespace Modules\Inventory\Services;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\SupplierAdvance;
use Modules\Inventory\Services\SupplierAccountingService;

class SupplierAdvanceService
{
    protected SupplierAccountingService $accountingService;

    public function __construct(SupplierAccountingService $accountingService)
    {
        $this->accountingService = $accountingService;
    }

    /**
     * Create new supplier advance with ledger + accounting entry
     */
    public function createWithAccounting(array $data): SupplierAdvance
    {
        return DB::transaction(function () use ($data) {

        if (empty($data['reference_no'])) {
            $data['reference_no'] = $this->generateReferenceNo();
        }

            $advance = SupplierAdvance::create([
                'supplier_id'     => $data['supplier_id'],
                'advance_amount'  => $data['advance_amount'],
                'adjusted_amount' => 0,
                'date'            => $data['date'] ?? now(),
                'payment_method'  => $data['payment_method'] ?? null,
                'reference_no'    => $data['reference_no'] ?? null,
                'note'            => $data['note'] ?? null,
                'type'            => 'advance',
                'branch_id'       => $data['branch_id'],
            ]);
            
            $this->createLedgerAndAccountingEntry($advance, data: $data);

            return $advance;
        });
    }

    /**
     * Update supplier advance and re-record ledger + accounting
     */
    public function updateWithAccounting(SupplierAdvance $advance, array $data): SupplierAdvance
    {
        return DB::transaction(function () use ($advance, $data) {

            $advance->update([
                'supplier_id'     => $data['supplier_id'],
                'advance_amount'  => $data['advance_amount'],
                'adjusted_amount' => $data['adjusted_amount'] ?? 0,
                'date'            => $data['date'] ?? now(),
                'payment_method'  => $data['payment_method'] ?? null,
                'note'            => $data['note'] ?? null,
            ]);
            

            $this->deleteLedgerAndAccountingEntry($advance);

            $this->createLedgerAndAccountingEntry($advance, $data);

            return $advance;
        });
    }

    /**
     * Delete supplier advance with linked ledger + accounting
     */
    public function deleteWithAccounting($advance): void
    {
        DB::transaction(function () use ($advance) {
            $this->deleteLedgerAndAccountingEntry($advance);
            $advance->delete();
        });
    }

    /**
     * Internal: create ledger + accounting entry
     */
    protected function createLedgerAndAccountingEntry(SupplierAdvance $advance, array $data): void
    {
        $this->accountingService->recordTransaction([
            'supplier_id' => $advance->supplier_id,
            'amount'      => $advance->advance_amount,
            'branch_id'   => $data['branch_id'],
            'reference_id'=> $advance->id, // can be prefixed if needed
            'reference_no'=> $advance->reference_no, // can be prefixed if needed
            'note'        => $data['note'] ?? null,
            'date'        => $advance->date,
            'user_selected_accounts' => [],
        ], 'advance');
    }

    /**
     * Internal: delete ledger + accounting entry
     */
    protected function deleteLedgerAndAccountingEntry($advance): void
    {
        
        $this->accountingService->deleteEntry($advance->id, 'advance');
    }

    
    protected function generateReferenceNo(): string
    {
        
        $lastRef = SupplierAdvance::where('reference_no', 'like', 'ADV-%')
            ->orderBy('id', 'desc')
            ->value('reference_no');

        if (!$lastRef) {
            return 'ADV-0001';
        }
        // Extract numeric part from last ref number
        $number = intval(str_replace('ADV-', '', $lastRef));

        // Next number increment
        $newNumber = $number + 1;

        // Format: ADV-0001, ADV-0002, ADV-0010 etc.
        return 'ADV-' . str_pad($newNumber, 4, '0', STR_PAD_LEFT);
    }




}
