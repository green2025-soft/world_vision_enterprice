<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types;



class StockTransferType 
{
    public function build(array $item, array $input, float $ratio=1): array
    {
        return [
             'product_id'       => $item['product_id'],
             'quantity'         => $item['quantity'],
             'unit_cost'        => $item['unit_cost'],
             'total_cost'       => $item['unit_cost']*$item['quantity'],
        ];
        
    }
}