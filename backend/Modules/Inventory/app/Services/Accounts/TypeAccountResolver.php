<?php
namespace Modules\Inventory\Services\Accounts;

use Modules\Inventory\Services\Accounts\Customer\CustomerPaymentService;
use Modules\Inventory\Services\Accounts\Customer\CustomerReturnService;
use Modules\Inventory\Services\Accounts\Customer\CustomerPreviousDueService;
use Modules\Inventory\Services\Accounts\Customer\CustomerAdvanceService;
use Modules\Inventory\Services\Accounts\Customer\SaleService;
use Modules\Inventory\Services\Accounts\Supplier\PurchaseService;
use Modules\Inventory\Services\Accounts\Supplier\PurchaseReturnService;
use Modules\Inventory\Services\Accounts\Supplier\SupplierPaymentService;
use Modules\Inventory\Services\Accounts\Supplier\SupplierPreviousDueService;
use Modules\Inventory\Services\Accounts\Supplier\SupplierAdvanceService;


 class TypeAccountResolver {

    public function resolve(string $type)
    {
        
        return match ($type) {
            'purchase'                  => app(PurchaseService::class),
            'supplier_payment'          => app(SupplierPaymentService::class),
            'sale'                      => app(SaleService::class),
            'purchase_return'           => app(PurchaseReturnService::class),
            'sale_return'               => app(CustomerReturnService::class),
            'customer_payment'          => app(CustomerPaymentService::class),
            'customer_previous_due'     => app(CustomerPreviousDueService::class),
            'supplier_previous_due'     => app(SupplierPreviousDueService::class),
            'customer_advance'          => app(CustomerAdvanceService::class),
            'supplier_advance'          => app(SupplierAdvanceService::class),
            default => throw new \Exception("Invalid type"),
        };
    }


}