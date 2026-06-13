<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types;


class PurchaseType extends TradeType
{
    public function build(
        array $item,
        array $input,
        float $ratio = 1
    ): array {

        $trade = $this->trade($item, $input, $ratio);
        
        return array_merge(
            $this->base($item, $input),
            $trade,
            [
                'reversed_cost' => $item['cost_price']
            ]
        );
    }
}