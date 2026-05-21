<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types;

use Modules\Inventory\Services\Inventory\Calculation\Resolvers\FinancialResolver;

abstract class TradeType extends BaseType
{
    public function __construct(
        protected FinancialResolver $financial,
    ) {}

    protected function trade(
        array $item,
        array $input,
        float $ratio = 1
    ): array {

        $qty = $item['quantity'];

        if ($qty <= 0) {
            throw new \Exception("Invalid quantity for product ID: {$item['product_id']}");
        }

        $price = $item['unit_price'];

        $subtotal = $qty * $price;

        // ---------------- DISCOUNT ----------------
        [$discountAmount, $discountPercent] =
            $this->financial->resolvePercent(
                $subtotal,
                $item['discount_amount'] ?? 0,
                $item['discount_percent'] ?? 0
            );

        $afterDiscount = $subtotal - $discountAmount;

        // ---------------- TAX ----------------
        [$taxAmount, $taxPercent] =
            $this->financial->resolvePercent(
                $afterDiscount,
                $item['tax_amount'] ?? 0,
                $item['tax_percent'] ?? 0
            );

        $netPrice = $afterDiscount + $taxAmount;


        // ---------------- COST + INVENTORY ----------------
        $costPrice = $this->financial->resolveCost($item)*$ratio;
        $inventoryValue = $this->financial->inventoryValue($item, $qty);

        return [
            'quantity'          => $qty,
            'unit_price'        => $price,
            'cost_price'        => $costPrice,
            'total_price'       => $subtotal,
            'net_price'         => $netPrice,

            'discount_amount'   => $discountAmount,
            'discount_percent'  => $discountPercent,

            'inventory_subtotal' => $inventoryValue,

            'tax_amount'        => $taxAmount,
            'tax_percent'       => $taxPercent,

            'invoice_date'      => $input['invoice_date'] ?? now(),
        ];
    }
}