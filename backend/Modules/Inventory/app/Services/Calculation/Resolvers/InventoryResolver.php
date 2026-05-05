<?php

namespace Modules\Inventory\Services\Calculation\Resolvers;

class InventoryResolver
{
    /**
     * COST PRICE
     */
    public function resolveCost(array $item): float
    {
        return (float) (
            $item['cost_price']
            ?? $item['purchase_price']
            ?? $item['unit_price']
            ?? 0
        );
    }

    /**
     * INVENTORY VALUE (COGS)
     */
    public function inventoryValue(array $item, float $qty): float
    {
        return $this->resolveCost($item) * $qty;
    }
}