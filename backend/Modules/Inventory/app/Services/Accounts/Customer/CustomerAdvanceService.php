<?php
namespace Modules\Inventory\Services\Accounts\Customer;


use Modules\Inventory\Services\Ledger\LedgerEntryBuilder;

abstract class CustomerAdvanceService extends CustomerAccountingService {


    public function __construct(
        protected LedgerEntryBuilder $ledgerBuilder
    ){}

    public function getByilderData(array $data, string $type): array
    {
        if (empty($data['reference_no'])) {
            $data['reference_no'] = $this->generateReferenceNo('CAV-', 4);
        }
        return $this->ledgerBuilder->buildReturn($data, $type);
    }
    protected function getAccountingType(string $type): array
    {
        return  ['module' => 'Customer Advance', 'source' => 'Customer Advance'];
    }

}