<?php

namespace Modules\Inventory\Services\Inventory\Calculation\Resolvers;

use Modules\Inventory\Models\StockTransfer;
use Modules\Inventory\Services\Inventory\Calculation\Types\PurchaseType;
use Modules\Inventory\Services\Inventory\Calculation\Types\SaleReturnType;
use Modules\Inventory\Services\Inventory\Calculation\Types\PurchaseReturnType;
use Modules\Inventory\Services\Inventory\Calculation\Types\SaleType;

class TypeResolver {

 public function resolve(string $type)
    {
        return match ($type) {

            'sale' => app(SaleType::class),

            'purchase' => app(PurchaseType::class),

            'purchase_return' => app(PurchaseReturnType::class),

            'sale_return' => app(SaleReturnType::class),

            'transfer' => app(StockTransfer::class),

            default => throw new \Exception("Invalid type"),
        };
    }

}