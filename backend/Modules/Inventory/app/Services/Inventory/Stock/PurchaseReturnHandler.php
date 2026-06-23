<?php 
namespace Modules\Inventory\Services\Inventory\Stock;
use Modules\Inventory\Services\Inventory\Stock\Movement\StockMovementService;
use Modules\Inventory\Services\Inventory\Stock\Movement\StockConsumptionService;
class PurchaseReturnHandler
{
    public function __construct(
        protected StockValidator $validator,
        protected StockMovementService $movement,
        protected StockConsumptionService $consumption,
        protected StockBalanceService $balance
    ) {}

    public function handle(object $source, array $items): void
    {
        
        
        foreach ($items as $item) {
            $oldQty = $this->movement->getPreviousQty(
                $item['product_id'],
                $source->branch_id,
                $source->id,
                [StockType::PURCHASE_RETURN, StockType::WASTAGE]
            )??0;

           $newQty = $item['return_qty'] + $item['wastage_qty'];
           $difference = $newQty - $oldQty;


            // SALE RETURN
            if (($item['return_qty'] ?? 0) > 0) {
                $applyItem =  $item;
                $applyItem['quantity'] = $item['return_qty'];
                $this->validator->validate(StockType::PURCHASE_RETURN, $applyItem, $source->branch_id);

                $this->movement->create(StockType::PURCHASE_RETURN, $source, [
                    'product_id' => $item['product_id'],
                    'quantity'   => $item['return_qty'],
                    'cost_price' => $item['cost_price'],
                    'unit_price' => $item['return_unit_price'],
                ]);
                
                $this->balance->apply(StockType::PURCHASE_RETURN, $applyItem, $source->branch_id);
            }

            // WASTAGE
            if (($item['wastage_qty'] ?? 0) > 0) {
                $applyItem = $item;
                $applyItem['quantity'] = $item['wastage_qty'];

                $this->validator->validate(StockType::PURCHASE_RETURN, $applyItem, $source->branch_id);

                $this->movement->create(StockType::WASTAGE, $source, [
                    'product_id' => $item['product_id'],
                    'quantity'   => $item['wastage_qty'],
                    'cost_price' => $item['cost_price'],
                    'unit_price' => $item['unit_purchase_price'],
                ]);

                
                $this->balance->apply(StockType::WASTAGE, $applyItem, $source->branch_id);
            }

             $this->consumption->updateStock(StockType::PURCHASE_RETURN, $item['product_id'], $source->branch_id, $source->purchase_id, abs($difference));
        }
    }
}