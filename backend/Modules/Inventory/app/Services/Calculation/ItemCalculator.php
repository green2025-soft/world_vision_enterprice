<?php

namespace Modules\Inventory\Services\Calculation;

use Modules\Inventory\Services\Calculation\Resolvers\FinancialResolver;
use Modules\Inventory\Services\Calculation\Resolvers\InventoryResolver;

class ItemCalculator
{
    public function __construct(
        protected FinancialResolver $financial,
        protected InventoryResolver $inventory,
        protected ItemTypeHandler $typeHandler
    ) {}

    public function calculate(array $items, array $input, string $type, $ratio=1): array
    {
        $result = [];
        
        foreach ($items as $item) {

            // ---------------- VALIDATION ----------------
            $productId = $item['product_id'] ?? null;

            if (!$productId) {
                throw new \Exception("Product ID missing");
            }

            $qty = (float) ($item['quantity'] ?? 0);

            if ($qty <= 0) {
                throw new \Exception("Invalid quantity for product ID: {$productId}");
            }

            // ---------------- PRICE ----------------
            $price = $this->financial->resolvePrice($item, $type);

            $subtotal = $qty * $price;

            // ---------------- DISCOUNT ----------------
            [$discountAmount, $discountPercent] =
                $this->financial->resolveDiscount(
                    $subtotal,
                    $item['discount_amount'] ?? 0,
                    $item['discount_percent'] ?? 0
                );

            $afterDiscount = $subtotal - $discountAmount;

            // ---------------- TAX ----------------
            [$taxAmount, $taxPercent] =
                $this->financial->resolveTax(
                    $afterDiscount,
                    $item['tax_amount'] ?? 0,
                    $item['tax_percent'] ?? 0
                );

            $netPrice = $afterDiscount + $taxAmount;

            // ---------------- COST + INVENTORY ----------------
            $costPrice = $this->inventory->resolveCost($item)*$ratio;
            $inventoryValue = $this->inventory->inventoryValue($item, $qty);

            // ---------------- BASE ITEM ----------------
            $itemData = [
                'product_id'    => $productId,
                'quantity'      => $qty,

                'unit_price'    => $price,
                'cost_price'    => $costPrice,

                'total_price'   => $subtotal,
                'net_price'     => $netPrice,

                'discount_amount'  => $discountAmount,
                'discount_percent' => $discountPercent,

                'tax_amount'  => $taxAmount,
                'tax_percent' => $taxPercent,

                'inventory_subtotal' => $inventoryValue,

                'branch_id'    => $input['branch_id'] ?? null,
                'invoice_date' => $input['invoice_date'] ?? now(),
            ];

            // ---------------- TYPE EXTRA ----------------
            $extra = $this->typeHandler->handle($type, $itemData, $ratio, $item);

            $result[] = array_merge($itemData, $extra);
        }

        return $result;
    }
}