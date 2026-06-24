<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types\Total;

class StockTransferTotal {


    public function calculate(array $items, array $input): array{
        $totalQty   = 0;
        $totalCost  = 0;

        foreach ($items as $item) {
            $totalQty       += $item['quantity'];
            $totalCost      += $item['unit_cost']; 
        }

        return [
            'total_quantity'        => $totalQty,
            'total_cost'            => round($totalCost,2),
        ];
    
    }
}