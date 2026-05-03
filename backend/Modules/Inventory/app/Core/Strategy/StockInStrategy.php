<?php

namespace Modules\Inventory\Core\Strategy;

class StockInStrategy
{
    public function handle($balance, $qty)
    {
        return $balance + $qty;
    }
}