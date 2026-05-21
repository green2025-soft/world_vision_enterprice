<?php

namespace Modules\Inventory\Services\Calculation\Resolvers;

class TypeWaseItemResolver
{

    public function handle(string $type, array $item, $ratio=1,  array $input): array
        {
             return match ($type) {
                 'sale' => [
                'profit' => ($ratio * $item['net_price']) - $item['inventory_subtotal'],
            ],

            'purchase' => [
                'sale_price' => $input['sale_price'],
            ],

            'sale_return' => [
                'return_value' => $input['net_price'],
            ],

            'purchase_return' => [
                'reversed_cost' => $item['inventory_subtotal'],
            ],

            'transfer' => [
                'transfer_cost' => $item['inventory_subtotal'],
            ],

            'wastage' => [
                'loss_amount' => $item['inventory_subtotal'],
            ],

            default => $item,
             };
        }
    
}