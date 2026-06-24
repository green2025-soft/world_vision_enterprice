<?php

namespace Modules\Inventory\Services\Inventory\Stock;

use Modules\Inventory\Services\Inventory\Stock\Movement\StockMovementService;
use Modules\Inventory\Services\Inventory\Stock\Movement\StockConsumptionService;

class StockService
{
    public function __construct(
        protected StockValidator $validator,
        protected StockBalanceService $balance,
        protected StockMovementService $movement,
        protected StockConsumptionService $consumption,
        protected PurchaseReturnHandler $purchaseReturn,
        protected SaleReturnHandler $sale_return
    ) {}


    public function handle(string $type, object $source, array $items){
         $type = trim((string) $type);
        return match ($type) {
            'purchase_return'   => $this->purchaseReturn->handle($source, $items),
            'sale_return'       => $this->sale_return->handle($source, $items),
            default             => $this->process($type, $source, $items)
        };
    }

    public function process(string $type, object $source, array $items): void
    {
        foreach ($items as $item) {
            
            $branchId =  $source->branch_id;
            // 1. VALIDATE
            $this->validator->validate($type, $item, $branchId);
            $productId = $item['product_id'];
            // 2. MOVEMENT FIRST 🔥
            $this->movement->delete($type, $source);
            $this->movement->create($type, $source, $item);

            // 3. FIFO LOGIC
            if (StockType::isStockOut($type)) {
                $this->consumption->consume(
                    $productId,
                    $item['quantity'],
                    $source->branch_id
                );
            }

        

            // 4. BALANCE LAST
           $currentStock = $this->consumption->currentStock($productId, $branchId);
           $this->balance->updateCurrentStock($productId, $branchId,  $currentStock);
            // $this->balance->apply($type, $item, $branchId);
        }
    }

    public function reverse(string $type, int $referenceId, $model=''): void
    {
        $this->movement->reverse($type, $referenceId, $model);
    }
}