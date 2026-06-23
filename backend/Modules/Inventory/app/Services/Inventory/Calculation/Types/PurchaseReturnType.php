<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types;



class PurchaseReturnType extends ReturnType
{
    public function build(array $item, array $input, float $ratio=1): array
    {
        $trade = $this->trade($item, $input, $ratio);

        $totalRefundPrice = $trade['total_return_price'] + ($item['unit_purchase_price'] * $item['wastage_qty']);

        return array_merge(
            $this->base($item, $input),
            $trade,
            [
                'unit_purchase_price'       => $item['unit_purchase_price'],
                'purchase_item_id'          => $item['purchase_item_id'],
                'total_refund_price'        => $totalRefundPrice,
            ]
        );
    
    }
}