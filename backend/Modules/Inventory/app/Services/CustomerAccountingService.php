<?php
namespace Modules\Inventory\Services;

use Modules\Inventory\Models\CustomerLedger;


class CustomerAccountingService extends BasePartyAccountingService
{
    protected string $ledgerModel = CustomerLedger::class;
    protected string $partyKey = 'customer_id';
    protected string $modulePrefix = 'Customer';


    protected function getAccountingMetaForType(string $type): array
    {
        return match ($type) {
            'sale'              => ['module' => 'Sale Voucher', 'source' => 'Sale Voucher'],
            'payment'           => ['module' => 'Customer Payment', 'source' => 'Customer Payment'],
            'advance'           => ['module' => 'Customer Advance', 'source' => 'Customer Advance'],
            'return'            => ['module' => 'Sale Return', 'source' => 'Return'],
            'adjustment'        => ['module' => 'Customer Adjustment', 'source' => 'Adjustment'],
            'opening_balance',
            'previous_due'      => ['module' => 'Customer Previous Due', 'source' => 'Customer Previous Due'],
            default             => throw new \InvalidArgumentException("Invalid transaction type: $type"),
        };
    }
}

