<?php

namespace Modules\Inventory\Services\Inventory\Calculation;

use Modules\Inventory\Services\Inventory\Calculation\Resolvers\TypeResolver;

class ItemCalculator
{


public function __construct(
        protected TypeResolver $typeResolver
    ) {}

    public function calculate(array $items, array $input, string $type, float $ratio = 1): array
    {
        $result = [];
        foreach ($items as $item) {
            // ---------------- VALIDATION ----------------
            $productId = $item['product_id'] ?? null;
            if (!$productId) {
                throw new \Exception("Product ID missing");
            }
            $result[] = $this->typeResolver->resolve($type)->build($item, $input, $ratio);
            
        }
        return $result;
    }
}