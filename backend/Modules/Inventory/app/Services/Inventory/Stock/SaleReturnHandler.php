<?php 
namespace Modules\Inventory\Services\Inventory\Stock;
class SaleReturnHandler
{
    public function __construct(
        protected StockService $stock
    ) {}

    public function handle(object $source, array $items): void
    {
        foreach ($items as $item) {

            if (($item['return_qty'] ?? 0) > 0) {

                $this->stock->process(
                    StockType::SALE_RETURN,
                    $source,
                    [[
                        'product_id' => $item['product_id'],
                        'quantity'   => $item['return_qty'],
                        'cost_price' => $item['cost_price'],
                        'unit_price' => $item['unit_price'],
                    ]]
                );
            }

            if (($item['wastage_qty'] ?? 0) > 0) {

                $this->stock->process(
                    StockType::WASTAGE,
                    $source,
                    [[
                        'product_id' => $item['product_id'],
                        'quantity'   => $item['wastage_qty'],
                        'cost_price' => $item['cost_price'],
                        'unit_price' => $item['unit_price'],
                    ]]
                );
            }
        }
    }
}