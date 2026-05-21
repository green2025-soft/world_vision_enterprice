<?php

namespace Modules\Inventory\Services\Calculation\Resolvers;

class FinancialResolver
{
    /**
     * PRICE (simple unified logic)
     */
    public function resolvePrice(array $item, string $type): float
    {
         return (float) (
            $item['unit_price']
            ?? $item['return_unit_price']
            ?? $item['wastage_unit_price']
            ?? 0
        );
        
    }

     public function resolveQuantity(array $item, string $type)
    {
        return match ($type) {
            'sale_return'   => $item['return_qty'],
            default         => $item['quantity']
        };  
    }

    /**
     * DISCOUNT
     */
    public function resolveDiscount(float $base, float $amount, float $percent): array
    {
        if ($amount > 0) {
            $percent = $base > 0 ? ($amount / $base) * 100 : 0;
        } elseif ($percent > 0) {
            $amount = ($percent / 100) * $base;
        }

        return [round($amount, 2), round($percent, 2)];
    }

    /**
     * TAX
     */
    public function resolveTax(float $base, float $amount, float $percent): array
    {
        if ($amount > 0) {
            $percent = $base > 0 ? ($amount / $base) * 100 : 0;
        } elseif ($percent > 0) {
            $amount = ($percent / 100) * $base;
        }

        return [round($amount, 2), round($percent, 2)];
    }

    public function resolveBaseItems(array $baseItem, $item, string $type)
    {
        return match ($type) {
            'sale_return'   => (function() use ($baseItem, $item) {
                $data = [
                    'sale_item_id'          => $item['id'],
                    'product_id'            => $item['product_id'],
                    'return_qty'            => $baseItem['quantity'],
                    'wastage_qty'           => $item['wastage_qty'],
                    'unit_sale_price'       => $item['unit_sale_price'],
                    'return_unit_price'     => $item['return_unit_price'],
                    'total_refund_price'    => $baseItem['total_price'],
                    'cost_price'            => $baseItem['cost_price'],
                ];
                return $data;
            }),
            default         => $baseItem
        };  
    }
}