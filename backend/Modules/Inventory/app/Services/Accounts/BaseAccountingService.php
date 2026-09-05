<?php

namespace Modules\Inventory\Services\Accounts;

use Illuminate\Support\Facades\DB;
use Modules\Accounting\Services\JournalService;

abstract class BaseAccountingService
{
    protected function journalService(): JournalService
    {
        return app(JournalService::class);
    }

    public function recordTransaction(array $data, string $type)
    {
        return DB::transaction(function () use ($data, $type) {
            $accountingData = $this->prepareAccountingData($data, $type);

            $accountingData['date']         = $accountingData['date'] ?? now();
            $accountingData['reference_id'] = $accountingData['reference_id'] ?? null;
            $accountingData['reference_no'] = $accountingData['reference_no'] ?? null;
            $accountingData['note']         = $accountingData['note'] ?? null;
            $accountingData['branch_id']    = $accountingData['branch_id'] ?? null;

            $builderData = $this->getBuilderData($accountingData, $type);
            
            if($builderData){
                $this->handleLedger($builderData,$accountingData, $type);
            }
            
            
        
            // Accounting
            $this->postAccounting($accountingData, $type);

            return true;
        });
    }

    protected function postAccounting(array $data,string $type) 
    {
        $meta = $this->getAccountingType($type);
        
        return $this->journalService()->create(
            feature_key: $type,
            module_key: 'inventory',
            sourceId: (int) $data['reference_id'],
            data: $data
        );
    }

    public function deleteEntry(array $data): void
    {
        $this->deleteLedger($data);

        $this->journalService()->deleteBySource(
            moduleName: 'inventory',
            sourceType: $data['source'],
            sourceId: (int) $data['sourceId']
        );
    }

    abstract protected function getBuilderData(array $data,string $type): array;

    abstract protected function handleLedger(array $builderData,array $data,string $type );

    abstract protected function deleteLedger(array $data);

    abstract protected function getAccountingType(string $type): array;

    protected function prepareAccountingData(array $data, string $type): array
    {
        return $data;
    }
}
