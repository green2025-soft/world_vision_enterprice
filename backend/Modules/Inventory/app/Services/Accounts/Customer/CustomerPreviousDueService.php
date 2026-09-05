<?php
namespace Modules\Inventory\Services\Accounts\Customer;


use Modules\Inventory\Services\Ledger\LedgerEntryBuilder;

class CustomerPreviousDueService extends CustomerAccountingService {


    public function __construct( protected LedgerEntryBuilder $ledgerBuilder){
         parent::__construct();
    }

    public function getBuilderData(array $data, string $type): array
    {
    
         return $this->ledgerBuilder->buildEntries($data,'opening_balance', $data['amount'], 'out');
    }

    protected function getAccountingType(string $type): array
    {
        return  ['source' => 'customer_previous_due'];
    }

}