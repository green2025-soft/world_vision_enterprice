<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types\Total;

class TradeTotal {
    protected function base(array $items, array $input): array
    {
        $subtotal       = array_sum(array_column($items, 'total_price'));
        $discount       = array_sum(array_column($items, 'discount_amount'));
        $tax            = array_sum(array_column($items, 'tax_amount'));
        $inventorySubtotal      = array_sum(array_column($items, 'inventory_subtotal'));

        $adjustment = $input['adjustment'] ?? 0;

        $netTotal = ($subtotal - $discount) + $tax + $adjustment;

        $paid = $input['paid_amount'] ?? 0;
        $advance = $input['advance_adjusted'] ?? 0;

        $due = max(0, $netTotal - ($paid + $advance));

        return [
            'subtotal'              => round($subtotal, 2),
            'total_discount'        => round($discount, 2),
            'total_tax'             => round($tax, 2),

            'adjustment'            => round($adjustment, 2),
            'net_total'             => round($netTotal, 2),

            'paid_amount'           => round($paid, 2),
            'advance_adjusted'      => round($advance, 2),
            'due_amount'            => round($due, 2),
            'inventory_subtotal'    => round($inventorySubtotal, 2),
            'total_amount'          => $subtotal,
        ];
    }

}