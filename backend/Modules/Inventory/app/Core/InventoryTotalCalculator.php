<?php 

namespace Modules\Inventory\Core;

class InventoryTotalCalculator
{

    public function calculateTotals(array $items): array
    {
        $totalPurchaseValue = 0;
        $totalSalesValue    = 0;
        $totalUnitValue     = 0;
        $totalDiscount      = 0;
        $totalTax           = 0;

        foreach ($items as $item) {

            $qty = $item['quantity'];

            $totalPurchaseValue += ($item['cost_price'] ?? 0) * $qty;
            $totalSalesValue    += ($item['sale_price'] ?? 0) * $qty;
            $totalUnitValue     += ($item['unit_price'] ?? 0) * $qty;

            $totalDiscount      += $item['discount_amount'] ?? 0;
            $totalTax           += $item['tax_amount'] ?? 0;
        }

        $netTotal = ($totalSalesValue - $totalDiscount) + $totalTax;

        return [
            'total_purchase_value' => $totalPurchaseValue,
            'total_sales_value'    => $totalSalesValue,
            'total_unit_value'     => $totalUnitValue,
            'total_discount_amount' => $totalDiscount,
            'total_tax_amount'      => $totalTax,
            'net_total'            => $netTotal,
        ];
    }

    private function percentAmountCal($price, $amount=0, $percent=0){
        if ($amount > 0) {
            // Calculate percent from amount
            $percent = $price > 0 ? ($amount / $price) * 100 : 0;
        } elseif ($percent > 0) {
            // Calculate amount from percent
            $amount = ($percent / 100) * $price;
        }
        return [
            'amount' => round($amount, 2),
            'percent' => round($percent, 2)
        ];
    
    }

}