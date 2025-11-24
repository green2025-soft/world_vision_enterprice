<?php

namespace Modules\Inventory\Services;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\Customer;

use Modules\Inventory\Services\CustomerAccountingService;

class CustomerPreviousDueService
{
   protected CustomerAccountingService $accountingService;

    public function __construct(CustomerAccountingService $accountingService)
    {
        $this->accountingService = $accountingService;
    }

    /**
     * Create new customer with ledger + accounting entry
     */
    public function createWithAccounting(array $data): Customer
    {
        return DB::transaction(function () use ($data) {

            $referenceNo = $this->generateReferenceNo();
            $createData = Customer::create($data);
            
            $data['reference_no'] = $referenceNo;
            $this->createLedgerAndAccountingEntry($createData, data: $data);

            return $createData;
        });
    }

    /**
     * Update customer advance and re-record ledger + accounting
     */
    public function updateWithAccounting(Customer $customer, array $data): Customer
    {
        return DB::transaction(function () use ($customer, $data) {

            $customer->update($data);
            
            $this->deleteLedgerAndAccountingEntry($customer);
            $referenceNo = $this->generateReferenceNo($customer->id);
            $data['reference_no'] = $referenceNo;

            $this->createLedgerAndAccountingEntry($customer, $data);

            return $customer;
        });
    }

    /**
     * Delete customer advance with linked ledger + accounting
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
    protected function createLedgerAndAccountingEntry(Customer $customer, array $data): void
    {
        $this->accountingService->recordTransaction([
            'customer_id' => $customer->id,
            'amount'      => $customer->previous_due,
            'branch_id'   => $customer->branch_id,
            'reference_id'=> $customer->id, // can be prefixed if needed
            'reference_no'=> $data['reference_no'], // can be prefixed if needed
            'note'        =>  null,
            'date'        => date('Y-m-d'),
        ], 'opening_balance');
    }

    /**
     * Internal: delete ledger + accounting entry
     */
    protected function deleteLedgerAndAccountingEntry($customer): void
    {
        
        $this->accountingService->deleteEntry($customer->id, 'opening_balance');
    }

    
    protected function generateReferenceNo($id=''): string
    {
        if ($id){
             return 'CPD-' . str_pad($id, 4, '0', STR_PAD_LEFT);
        }

        $lastRef = Customer::orderBy('id', 'desc')
            ->value('id');

        if (!$lastRef) {
            return 'CPD-0001';
        }
        // Extract numeric part from last ref number
        $number = intval(str_replace('CPD-', '', $lastRef));

        // Next number increment
        $newNumber = $number + 1;

        return 'CPD-' . str_pad($newNumber, 4, '0', STR_PAD_LEFT);
    }




}
