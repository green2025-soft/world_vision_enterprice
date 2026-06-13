<?php

namespace Modules\Inventory\Services\Accounts\Customer;

use Modules\Inventory\Services\Ledger\LedgerEntryBuilder;
use Illuminate\Support\Facades\App;

class CustomerPaymentService extends CustomerAccountingService
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
        
        return $this->ledgerBuilder->buildPayment($data, $type);
    }

    protected function getAccountingType(string $type): array
    {
        return [
            'module' => 'Customer Due Payment',
            'source' => 'Customer Payment Voucher'
        ];
    }
}