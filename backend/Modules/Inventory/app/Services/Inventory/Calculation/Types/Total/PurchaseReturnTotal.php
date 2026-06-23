<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types\Total;

class PurchaseReturnTotal {


    public function calculate(array $items, array $input): array{
        $returnAmount = 0;
        $refundAmount = 0;
        $wastageAmount = 0;
        $wastageAmountCost = 0;
        $inventoryAmount = 0;
        $returnedStock     = 0;
        
        

        foreach ($items as $item) {

            $unitPrice = $item['cost_price'];
  
            $wastageQty = $item['wastage_qty'] ?? 0;
            $purchaseUnitPrice = $item['unit_purchase_price'] ?? 0;

            $returnAmount += $item['total_return_price'];
            $refundAmount += $item['total_refund_price'];

            $wastageAmountCost  += ($wastageQty * $unitPrice);
            $wastageAmount      += ($purchaseUnitPrice * $wastageQty);
            
            $totalReturnQty     = $wastageQty+$item['return_qty'];
            $inventory          = ($totalReturnQty * $unitPrice);
            $inventoryAmount    += $inventory;
            $returnedStock      += $unitPrice*$item['return_qty']; 
        }


        return [
            // settlement
            'total_return_amount'       => round($returnAmount,2),
            'total_refund_amount'       => round($refundAmount,2),
            'adjusted_due_amount'       => $input['due_adjusted'],
            'cash_refund_amount'        => $input['cash_return'],
            'supplier_advance'          => $input['supplier_advance'],

            // stock
            'returned_stock'            => round($returnedStock, 2),
            'wastage_amount'            => round($wastageAmountCost,2),
            'wastage_amount_purchase'   => round($wastageAmount,2),
            'inventory'                 => round($inventoryAmount,2),
            'demurrage_stock'           => round($inventoryAmount- $refundAmount)
        ];
    
    }
}