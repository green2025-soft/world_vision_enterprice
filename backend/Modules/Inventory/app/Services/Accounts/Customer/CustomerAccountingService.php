<?php

namespace Modules\Inventory\Services\Accounts\Customer;

use Modules\Inventory\Services\Accounts\BaseAccountingService;
use Modules\Inventory\Services\Ledger\TransactionLedgerService;

abstract class CustomerAccountingService extends BaseAccountingService
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
            ->customer()
            ->store($builderData);
    }
}