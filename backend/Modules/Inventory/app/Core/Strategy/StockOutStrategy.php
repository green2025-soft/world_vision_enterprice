<?php
namespace Modules\Inventory\Core\Strategy;

class StockOutStrategy
{
    public function handle($balance, $qty)
    {
        if ($balance < $qty) {
            throw new \Exception("Insufficient stock");
        }

        return $balance - $qty;
    }
}