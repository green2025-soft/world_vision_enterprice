<?php
namespace Modules\Inventory\Services\Accounts\Supplier;


use Modules\Inventory\Services\Ledger\LedgerEntryBuilder;

class SupplierPreviousDueService extends SupplierAccountingService {


    public function __construct( protected LedgerEntryBuilder $ledgerBuilder){
         parent::__construct();
    }

    public function getBuilderData(array $data, string $type): array
    {
     
         return $this->ledgerBuilder->buildEntries($data,'opening_balance', $data['amount'], 'out');
    }

    protected function getAccountingType(string $type): array
    {
        return  ['source' => 'supplier_previous_due'];
    }

}