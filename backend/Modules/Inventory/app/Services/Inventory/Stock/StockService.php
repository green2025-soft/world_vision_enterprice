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
        protected SaleReturnHandler $sale_return,
        protected StockTransferHandler $stockTransfer,
        protected ProductWastageHandler $productWastage
    ) {}


    public function handle(string $type, object $source, array $items){
         $type = trim((string) $type);
        return match ($type) {
            'purchase_return'   => $this->purchaseReturn->handle($source, $items),
            'sale_return'       => $this->sale_return->handle($source, $items),
            'transfer'          => $this->stockTransfer->handle($type, $source, $items),
            'wastage'           => $this->productWastage->handle($type, $source, $items),
            default             => $this->process($type, $source, $items),
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
        
        if($type =='transfer'){
            $outModel = $model; 
            $outModel->branch_id = $model->from_branch_id;

            $this->movement->reverse('transfer_out', $referenceId, $outModel);
            
            $inModel = $model; 
            $inModel->branch_id = $model->to_branch_id;
            $this->movement->reverse('transfer_in', $referenceId, $inModel);

        }else{
            $this->movement->reverse($type, $referenceId, $model);
        }
    }
}