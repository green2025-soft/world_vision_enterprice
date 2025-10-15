<?php
namespace Modules\Inventory\Services;


use Modules\Inventory\Models\SupplierLedger;

class SupplierAccountingService extends BasePartyAccountingService
{
    protected string $ledgerModel = SupplierLedger::class;
    protected string $partyKey = 'supplier_id';
    protected string $modulePrefix = 'Supplier';


    protected function getAccountingMetaForType(string $type): array
    {
        return match ($type) {
            'purchase'         => ['module' => 'Purchase Voucher', 'source' => 'Purchase Voucher'],
            'payment'          => ['module' => 'Supplier Payment', 'source' => 'Supplier Payment'],
            'advance'          => ['module' => 'Supplier Advance', 'source' => 'Supplier Advance'],
            'return'           => ['module' => 'Purchase Return', 'source' => 'Return'],
            'adjustment'       => ['module' => 'Supplier Adjustment', 'source' => 'Adjustment'],
            'opening_balance',
            'previous_due'     => ['module' => 'Supplier Previous Due', 'source' => 'Supplier Previous Due'],
            default            => throw new \InvalidArgumentException("Invalid transaction type: $type"),
        };
    }
}

