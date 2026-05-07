<?php

namespace Modules\Inventory\Services\Return;

use Modules\Inventory\Services\Stock\StockService;
use Modules\Inventory\Services\Calculation\ItemCalculator;

class ReturnProcessor
{
    public function __construct(
        protected StockService $stockService,
        protected ItemCalculator $calculator
    ) {}

    public function process(object $source, array $items): array
    {
        // 1. CALCULATE RETURN ITEMS
        $calculated = $this->calculator->calculate(
            $items,
            (array) $source,
            'sale_return'
        );

        foreach ($calculated as $item) {

            $qty = $item['quantity'];

            $returnQty  = $item['return_qty'] ?? 0;
            $wastageQty = $item['wastage_qty'] ?? 0;

            // -----------------------------------
            // 2. STOCK RESTORE (ONLY RETURN)
            // -----------------------------------
            if ($returnQty > 0) {

                $this->stockService->process(
                    'sale_return',
                    $source,
                    [[
                        'product_id' => $item['product_id'],
                        'quantity'   => $returnQty,
                        'cost_price'  => $item['cost_price'],
                        'unit_price'  => $item['unit_price'],
                    ]]
                );
            }

            // -----------------------------------
            // 3. WASTAGE HANDLING (NO RESTORE)
            // -----------------------------------
            if ($wastageQty > 0) {

                $this->stockService->process(
                    'wastage',
                    $source,
                    [[
                        'product_id' => $item['product_id'],
                        'quantity'   => $wastageQty,
                        'cost_price' => $item['cost_price'],
                        'unit_price' => $item['unit_price'],
                    ]]
                );
            }
        }

        return $calculated;
    }
}