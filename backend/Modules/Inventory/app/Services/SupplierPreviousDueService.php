<?php

namespace Modules\Inventory\Services;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\Supplier;
use Modules\Inventory\Services\SupplierAccountingService;

class SupplierPreviousDueService
{
    protected SupplierAccountingService $accountingService;

    public function __construct()
    {
        $this->accountingService = new SupplierAccountingService('Supplier Previous Due', 'Supplier Previous Due');;
    }

    /**
     * Create new supplier with ledger + accounting entry
     */
    public function createWithAccounting(array $data): Supplier
    {
        return DB::transaction(function () use ($data) {

            $referenceNo = $this->generateReferenceNo();
            $createData = Supplier::create($data);
            
            $data['reference_no'] = $referenceNo;
            $this->createLedgerAndAccountingEntry($createData, data: $data);

            return $createData;
        });
    }

    /**
     * Update supplier advance and re-record ledger + accounting
     */
    public function updateWithAccounting(Supplier $supplier, array $data): Supplier
    {
        return DB::transaction(function () use ($supplier, $data) {

            $supplier->update($data);
            
            $this->deleteLedgerAndAccountingEntry($supplier);
            $referenceNo = $this->generateReferenceNo($supplier->id);
            $data['reference_no'] = $referenceNo;

            $this->createLedgerAndAccountingEntry($supplier, $data);

            return $supplier;
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
    protected function createLedgerAndAccountingEntry(Supplier $supplier, array $data): void
    {
        $this->accountingService->recordTransaction([
            'supplier_id' => $supplier->id,
            'amount'      => $supplier->previous_due,
            'branch_id'   => $supplier->branch_id,
            'reference_id'=> $supplier->id, // can be prefixed if needed
            'reference_no'=> $data['reference_no'], // can be prefixed if needed
            'note'        =>  null,
            'date'        => date('Y-m-d'),
        ], 'opening_balance');
    }

    /**
     * Internal: delete ledger + accounting entry
     */
    protected function deleteLedgerAndAccountingEntry($supplier): void
    {
        
        $this->accountingService->deleteEntry($supplier->id, 'opening_balance');
    }

    
    protected function generateReferenceNo($id=''): string
    {
        if ($id){
             return 'SPD-' . str_pad($id, 4, '0', STR_PAD_LEFT);
        }

        $lastRef = Supplier::orderBy('id', 'desc')
            ->value('id');

        if (!$lastRef) {
            return 'SPD-0001';
        }
        // Extract numeric part from last ref number
        $number = intval(str_replace('SPD-', '', $lastRef));

        // Next number increment
        $newNumber = $number + 1;

        return 'SPD-' . str_pad($newNumber, 4, '0', STR_PAD_LEFT);
    }




}
