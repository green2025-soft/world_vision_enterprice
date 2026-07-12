<?php 
namespace Modules\Inventory\Services\Inventory\Stock;
use Modules\Inventory\Services\Inventory\Stock\Movement\StockMovementService;
use Modules\Inventory\Services\Inventory\Stock\Movement\StockConsumptionService;
class ProductWastageHandler
{
    public function __construct(
        protected StockValidator $validator,
        protected StockMovementService $movement,
        protected StockConsumptionService $consumption,
        protected StockBalanceService $balance
    ) {}

    public function handle(string $type, object $source, array $items): void
{
    foreach ($items as $item) {
        
        $branchId = $source->branch_id;

        $productId = $item['product_id'];
        $qty       = $item['quantity'];
      
        /*
        |--------------------------------------------------------------------------
        | 1. VALIDATION (ONLY FROM BRANCH STOCK)
        |--------------------------------------------------------------------------
        */

        $this->validator->validate($type, $item, $branchId);

        /*
        |--------------------------------------------------------------------------
        | 2. FIFO CONSUME (FROM BRANCH)
        |--------------------------------------------------------------------------
        */

        if (StockType::isStockOut($type)) {

            // reduce stock from source (FIFO layers)
            $this->consumption->consume(
                $productId,
                $qty,
                $branchId
            );
        }

        /*
        |--------------------------------------------------------------------------
        | 3. CREATE MOVEMENT (FROM + TO BOTH SIDE LOGIC)
        |--------------------------------------------------------------------------
        */

        $this->movement->create('transfer_out', $source, [
            'product_id'    => $productId,
            'quantity'      => $qty,
            'unit_cost'     => $item['cost_price'] ?? 0,
            'unit_price'    => $item['unit_price'] ?? 0,
        ]);
    
        /*
        |--------------------------------------------------------------------------
        | 4. BALANCE UPDATE (BOTH BRANCHES)
        |--------------------------------------------------------------------------
        */

        $fromStock = $this->consumption->currentStock($productId, $branchId);
        
        $this->balance->updateCurrentStock($productId, $branchId, $fromStock);
        
    }
}
}