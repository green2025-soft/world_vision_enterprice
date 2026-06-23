<?php

namespace Modules\Inventory\Services\Accounts;

use Illuminate\Support\Facades\DB;
use Modules\Accounting\Services\AccountingManagerService;
use Illuminate\Support\Facades\App;
abstract class BaseAccountingService
{
    // protected AccountingManagerService $accountingService;

    public function __construct()
    {
        // ONLY HERE
        // $this->accountingService = app(AccountingManagerService::class);
    }

    protected function accountingService(): AccountingManagerService
    {
        return app(AccountingManagerService::class);
    }

    public function recordTransaction(array $data, string $type)
    {
        return DB::transaction(function () use ($data, $type) {

            $amount = floatval($data['amount']);

            $data['date']         = $data['date'] ?? now();
            $data['reference_id'] = $data['reference_id'] ?? null;
            $data['reference_no'] = $data['reference_no'] ?? null;
            $data['note']         = $data['note'] ?? null;
            $data['branch_id']    = $data['branch_id'] ?? null;

            $builderData = $this->getBuilderData($data, $type);

            $this->handleLedger($builderData, $data, $type);

            // ACCOUNTING ONLY HERE
            $this->postAccounting($data, $type);

            return true;
        });
    }

    protected function postAccounting(array $data, string $type)
    {
        $meta = $this->getAccountingType($type);
        $this->accountingService()->createEntryFromModule(
            moduleName: $meta['module'],
            sourceType: $meta['source'],
            sourceId: $data['reference_id'] ?? null,
            data: $data
        );
    }


    public function deleteEntry(array $data): void
    {
        $this->deleteLedger($data);

        $this->accountingService()->deleteEntryFromModule(
            moduleName: $data['module'],
            sourceType: $data['source'],
            sourceId: $data['sourceId']
        );
    }

    abstract protected function getBuilderData(array $data, string $type): array;

    abstract protected function handleLedger(array $builderData, array $data, string $type);

    abstract protected function deleteLedger( array $data);

    abstract protected function getAccountingType(string $type): array;
}