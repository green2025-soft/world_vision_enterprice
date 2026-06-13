<?php

namespace Modules\Inventory\Services\Accounts\Supplier;

use Modules\Inventory\Services\Accounts\BaseAccountingService;
use Modules\Inventory\Services\Ledger\TransactionLedgerService;

abstract class SupplierAccountingService extends BaseAccountingService
{
    protected TransactionLedgerService $ledgerService;

    public function __construct()
    {
         parent::__construct();
        $this->ledgerService = app(TransactionLedgerService::class);
    }

    protected function handleLedger(array $builderData, array $data, string $type)
    {
        return $this->ledgerService
            ->supplier()
            ->store($builderData);
    }

     protected function deleteLedger(array $data)
    {
        return $this->ledgerService
            ->supplier()
            ->delete($data);
    }

}