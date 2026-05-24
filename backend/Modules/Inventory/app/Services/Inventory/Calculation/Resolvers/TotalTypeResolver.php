<?php

namespace Modules\Inventory\Services\Inventory\Calculation\Resolvers;

use Modules\Inventory\Services\Inventory\Calculation\Types\Total\PurchaseTotal;
use Modules\Inventory\Services\Inventory\Calculation\Types\Total\SaleTotal;
use Modules\Inventory\Services\Inventory\Calculation\Types\Total\SaleReturnTotal;

class TotalTypeResolver {

 public function resolve(string $type)
    {
        return match ($type) {

            'sale' => app(SaleTotal::class),

            'purchase' => app(PurchaseTotal::class),

            'sale_return' => app(SaleReturnTotal::class),

            default => throw new \Exception("Invalid type"),
        };
    }

}