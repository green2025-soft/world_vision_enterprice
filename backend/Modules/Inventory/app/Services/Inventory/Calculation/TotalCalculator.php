<?php

namespace Modules\Inventory\Services\Inventory\Calculation;

use Modules\Inventory\Services\Inventory\Calculation\Resolvers\TotalTypeResolver;

class TotalCalculator {

    public function __construct(
        protected TotalTypeResolver $totalTypeResolver
    ){}
    
    public function calculate(array $items, array $input, string $type): array
    {
        return $this->totalTypeResolver->resolve($type)->calculate($items, $input);
    }
}