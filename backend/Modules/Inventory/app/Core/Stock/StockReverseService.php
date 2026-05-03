<?php 
namespace Modules\Inventory\Core\Stock;

class StockReverseService
{
    public function reverseType(string $type): string
    {
        return match ($type) {
            'purchase'        => 'purchase_return',
            'sale'            => 'sale_return',
            'sale_return'     => 'sale',
            'purchase_return' => 'purchase',
        };
    }
}