<?php

namespace Modules\Inventory\Services\Calculation\Resolvers;

class FinancialResolver
{
    /**
     * PRICE (simple unified logic)
     */
    public function resolvePrice(array $item, string $type): float
    {
        return (float) ($item['unit_price'] ?? 0);
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
}