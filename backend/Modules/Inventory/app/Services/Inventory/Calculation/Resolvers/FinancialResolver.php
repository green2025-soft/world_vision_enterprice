<?php

namespace Modules\Inventory\Services\Inventory\Calculation\Resolvers;

class FinancialResolver
{
    public function resolvePercent(float $base, float $amount, float $percent): array
    {
        if ($amount > 0) {
            $percent = $base > 0 ? ($amount / $base) * 100 : 0;
        } elseif ($percent > 0) {
            $amount = ($percent / 100) * $base;
        }

        return [round($amount, 2), round($percent, 2)];
    }


    public function resolveCost(array $item): float
    {
        return (float) (
            $item['cost_price']
            ?? $item['purchase_price']
            ?? $item['unit_price']
            ?? 0
        );
    }

    public function inventoryValue(array $item, float $qty): float
    {
        return $this->resolveCost($item) * $qty;
    }
}