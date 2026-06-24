<?php 
namespace Modules\Inventory\Services\Inventory\Stock;
use Modules\Inventory\Services\Inventory\Stock\Movement\StockMovementService;
use Modules\Inventory\Services\Inventory\Stock\Movement\StockConsumptionService;
class StockTransferHandler
{
    public function __construct(
        protected StockValidator $validator,
        protected StockMovementService $movement,
        protected StockConsumptionService $consumption,
        protected StockBalanceService $balance
    ) {}

    public function process(string $type, object $source, array $items): void
{
    foreach ($items as $item) {

        $fromBranch = $source->from_branch_id;
        $toBranch   = $source->to_branch_id;

        $productId = $item['product_id'];
        $qty       = $item['quantity'];

        /*
        |--------------------------------------------------------------------------
        | 1. VALIDATION (ONLY FROM BRANCH STOCK)
        |--------------------------------------------------------------------------
        */

        $this->validator->validate($type, $item, $fromBranch);

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
                $fromBranch
            );
        }

        /*
        |--------------------------------------------------------------------------
        | 3. CREATE MOVEMENT (FROM + TO BOTH SIDE LOGIC)
        |--------------------------------------------------------------------------
        */

        // OUT from source branch
        $this->movement->create('transfer_out', $source, [
            'product_id' => $productId,
            'quantity'   => $qty,
            'branch_id'  => $fromBranch,
        ]);

        // IN to destination branch
        $this->movement->create('transfer_in', $source, [
            'product_id' => $productId,
            'quantity'   => $qty,
            'branch_id'  => $toBranch,
        ]);

        /*
        |--------------------------------------------------------------------------
        | 4. BALANCE UPDATE (BOTH BRANCHES)
        |--------------------------------------------------------------------------
        */

        $fromStock = $this->consumption->currentStock($productId, $fromBranch);
        $toStock   = $this->consumption->currentStock($productId, $toBranch);

        $this->balance->updateCurrentStock($productId, $fromBranch, $fromStock);
        $this->balance->updateCurrentStock($productId, $toBranch, $toStock);
    }
}
}