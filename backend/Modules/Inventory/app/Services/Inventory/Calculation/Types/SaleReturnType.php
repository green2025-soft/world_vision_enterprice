<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types;



class SaleReturnType extends ReturnType
{
    public function build(array $item, array $input, float $ratio): array
    {
        $trade = $this->trade($item, $input, $ratio);

        $totalRefundPrice = $trade['total_return_price'] + ($item['unit_sale_price'] * $item['wastage_qty']);

        return array_merge(
            $this->base($item, $input),
            $trade,
            [
                'unit_sale_price'       => $item['unit_sale_price'],
                'sale_item_id'          => $item['sale_item_id'],
                'total_refund_price'    => $totalRefundPrice,
            ]
        );
    
    }
}