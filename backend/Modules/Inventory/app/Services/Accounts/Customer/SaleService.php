<?php

namespace Modules\Inventory\Services\Accounts\Customer;

use Modules\Inventory\Services\Ledger\LedgerEntryBuilder;
use Illuminate\Support\Facades\App;

class SaleService extends CustomerAccountingService
{
    protected LedgerEntryBuilder $ledgerBuilder;

    public function __construct()
    {
        parent::__construct();

        // ONLY ONE DI
        $this->ledgerBuilder = App::make(LedgerEntryBuilder::class);
    }

   public function getBuilderData(array $data, string $type): array
    {
        
        return $this->ledgerBuilder->build($data, $type);
    }

    protected function getAccountingType(string $type): array
    {
        return [
            'module' => 'Sales Voucher',
            'source' => 'Sale'
        ];
    }
}