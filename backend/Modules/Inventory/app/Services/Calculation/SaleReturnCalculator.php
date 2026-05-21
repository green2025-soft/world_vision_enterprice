<?php 
namespace Modules\Inventory\Services\Calculation;

class SaleReturnCalculator
{
    public function calculate(array $items,array $input): array {


        $returnAmount = 0;
        $wastageAmount = 0;

        foreach ($items as $item) {

            $unitPrice = $item['cost_price'];
            $returnPrice = $item['refund_unit_price'];

            $returnQty = $item['return_qty'] ?? 0;

            $wastageQty = $item['wastage_qty'] ?? 0;

            $returnAmount += ($returnQty * $returnPrice);

            $wastageAmount += ($wastageQty * $unitPrice);
        }

        $refundAmount = ($returnAmount + $wastageAmount);

        return [
            'return_amount'         => round($returnAmount,2),
            'wastage_amount'        => round($wastageAmount,2),
            'refund_amount'         => round($refundAmount,2),
            'total_return_amount'   => round($refundAmount,2),
        ];
    }
}