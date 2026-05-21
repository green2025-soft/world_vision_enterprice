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
        protected SaleReturnHandler $sale_return
    ) {}


    public function handle(string $type, object $source, array $items){
        return match ($type) {
            'sale_return'   => (function() use ($source, $items) {
                return $this->sale_return->handle($source, $items);
            }),
            default => $this->process($type, $source, $items)
        };
    }

    public function process(string $type, object $source, array $items): void
    {
        foreach ($items as $item) {

            // 1. VALIDATE
            $this->validator->validate($type, $item, $source->branch_id);

            // 2. MOVEMENT FIRST 🔥
            $this->movement->create($type, $source, $item);

            // 3. FIFO LOGIC
            if (StockType::isStockOut($type)) {
                $this->consumption->consume(
                    $item['product_id'],
                    $item['quantity'],
                    $source->branch_id
                );
            }

            if ($type === StockType::SALE_RETURN) {
                $this->consumption->restore(
                    $item['product_id'],
                    $item['quantity'],
                    $source->branch_id
                );
            }

            // 4. BALANCE LAST
            $this->balance->apply($type, $item, $source->branch_id);
        }
    }

    public function reverse(string $type, int $referenceId): void
    {
        $this->movement->reverse($type, $referenceId);
        $this->balance->reverse($type, $referenceId);
    }
}