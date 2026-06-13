<?php

namespace Modules\Inventory\Services\Accounts\Supplier;

use Modules\Inventory\Services\Ledger\LedgerEntryBuilder;
use Illuminate\Support\Facades\App;


class PurchaseService extends SupplierAccountingService
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
            'module' => 'Purchase Voucher',
            'source' => 'Purchase'
        ];
    }
}