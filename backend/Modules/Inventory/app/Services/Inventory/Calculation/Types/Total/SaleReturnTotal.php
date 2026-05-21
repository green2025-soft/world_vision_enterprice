<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types\Total;

class SaleReturnTotal {


    public function calculate(array $items, array $input): array{
        $returnAmount = 0;
        $refundAmount = 0;
        $wastageAmount = 0;

        foreach ($items as $item) {

            $unitPrice = $item['cost_price'];
  
            $wastageQty = $item['wastage_qty'] ?? 0;

            $returnAmount += $item['total_return_price'];
            $refundAmount += $item['total_refund_price'];

            $wastageAmount += ($wastageQty * $unitPrice);
        }


        return [
            'total_return_amount'   => round($returnAmount,2),
            'total_refund_amount'   => round($refundAmount,2),
            'adjusted_due_amount'   => $input[''],
            'cash_refund_amount'    => $input[''],
            'customer_advance'      => $input[''],
            'wastage_amount'        => round($wastageAmount,2),
        ];
    
    }
}