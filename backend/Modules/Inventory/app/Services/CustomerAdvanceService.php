<?php

namespace Modules\Inventory\Services;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\CustomerAdvance;
use Modules\Inventory\Services\CustomerAccountingService;

class CustomerAdvanceService
{
    protected CustomerAccountingService $accountingService;

    

    public function __construct(CustomerAccountingService $accountingService)
    {
        $this->accountingService = $accountingService;
    }

    /**
     * Create new supplier advance with ledger + accounting entry
     */
    public function createWithAccounting(array $data): CustomerAdvance
    {
        return DB::transaction(function () use ($data) {

        if (empty($data['reference_no'])) {
            $data['reference_no'] = $this->generateReferenceNo();
        }

            $advance = CustomerAdvance::create([
                'customer_id'     => $data['customer_id'],
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
    public function updateWithAccounting(CustomerAdvance $advance, array $data): CustomerAdvance
    {
        return DB::transaction(function () use ($advance, $data) {

            $advance->update([
                'customer_id'     => $data['customer_id'],
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
    protected function createLedgerAndAccountingEntry(CustomerAdvance $advance, array $data): void
    {
        $this->accountingService->recordTransaction([
            'customer_id' => $advance->customer_id,
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
        
        $lastRef = CustomerAdvance::where('reference_no', 'like', 'CAV-%')
            ->orderBy('id', 'desc')
            ->value('reference_no');

        if (!$lastRef) {
            return 'CAV-0001';
        }
        // Extract numeric part from last ref number
        $number = intval(str_replace('CAV-', '', $lastRef));

        // Next number increment
        $newNumber = $number + 1;

        // Format: CAV-0001, CAV-0002, CAV-0010 etc.
        return 'CAV-' . str_pad($newNumber, 4, '0', STR_PAD_LEFT);
    }




}
