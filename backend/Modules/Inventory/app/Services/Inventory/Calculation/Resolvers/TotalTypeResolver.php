<?php

namespace Modules\Inventory\Services\Inventory\Calculation\Resolvers;

use Modules\Inventory\Services\Inventory\Calculation\Types\Total\PurchaseTotal;
use Modules\Inventory\Services\Inventory\Calculation\Types\Total\SaleTotal;
use Modules\Inventory\Services\Inventory\Calculation\Types\Total\SaleReturnTotal;
use Modules\Inventory\Services\Inventory\Calculation\Types\Total\PurchaseReturnTotal;
use Modules\Inventory\Services\Inventory\Calculation\Types\Total\StockTransferTotal;

class TotalTypeResolver {

 public function resolve(string $type)
    {
        return match ($type) {

            'purchase'          => app(PurchaseTotal::class),
            'sale'              => app(SaleTotal::class),

            'purchase_return'   => app(PurchaseReturnTotal::class),
            'sale_return'       => app(SaleReturnTotal::class),
            'transfer'          => app(StockTransferTotal::class),

            default => throw new \Exception("Invalid type"),
        };
    }

}