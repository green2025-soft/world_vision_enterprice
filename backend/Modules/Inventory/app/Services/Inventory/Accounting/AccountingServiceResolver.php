<?php
namespace Modules\Inventory\Services\Inventory\Accounting;
use Modules\Inventory\Services\CustomerAccountingService;
use Modules\Inventory\Services\SupplierAccountingService;

class AccountingServiceResolver
{
    public function __construct(
        protected CustomerAccountingService $customer,
        protected SupplierAccountingService $supplier,
    ) {}

    public function resolve(string $type)
    {
        return match ($type) {

            'sale'              => $this->customer,
            'sale_return'       => $this->customer,

            'purchase'          => $this->supplier,
            'purchase_return'   => $this->supplier,

            default             => $this->customer,
        };
    }
}