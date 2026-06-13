<?php
namespace Modules\Inventory\Services\Accounts;

use Modules\Inventory\Services\Accounts\Customer\CustomerPaymentService;
use Modules\Inventory\Services\Accounts\Customer\CustomerReturnService;
use Modules\Inventory\Services\Accounts\Customer\SaleService;
use Modules\Inventory\Services\Accounts\Supplier\PurchaseService;
use Modules\Inventory\Services\Accounts\Supplier\PurchaseReturnService;
use Modules\Inventory\Services\Accounts\Supplier\SupplierPaymentService;


 class TypeAccountResolver {

    public function resolve(string $type)
    {
        
        return match ($type) {
            'purchase'          => app(PurchaseService::class),
            'supplier_payment'  => app(SupplierPaymentService::class),
            'sale'              => app(SaleService::class),
            'purchase_return'   => app(PurchaseReturnService::class),
            'sale_return'       => app(CustomerReturnService::class),
            'customer_payment'  => app(CustomerPaymentService::class),
            default => throw new \Exception("Invalid type"),
        };
    }


}