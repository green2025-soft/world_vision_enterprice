<?php 

namespace Modules\Inventory\Services\Inventory\Calculation\Types\Total;

class SaleTotal extends TradeTotal {
    

    public function calculate(array $items, array $input): array
    {
        return $this->base($items, $input);
    }

}