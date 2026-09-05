<?php
namespace Modules\Inventory\Services\Accounts\Customer;


use Modules\Inventory\Services\Ledger\LedgerEntryBuilder;

abstract class CustomerAdvanceService extends CustomerAccountingService {


    public function __construct(
        protected LedgerEntryBuilder $ledgerBuilder
    ){}

    public function getByilderData(array $data, string $type): array
    {
        return $this->ledgerBuilder->buildEntries($data,'advance', $data['amount'], 'in');
        
        return $this->ledgerBuilder->buildReturn($data, $type);
    }
    protected function getAccountingType(string $type): array
    {
        return  ['source' => 'customer_advance'];
    }

}