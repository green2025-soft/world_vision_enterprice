<?php

namespace Modules\Inventory\Services\Stock;

use Modules\Inventory\Services\Stock\Movement\StockMovementService;
use Modules\Inventory\Services\Stock\Movement\StockConsumptionService;

class StockService
{
    public function __construct(
        protected StockValidator $validator,
        protected StockBalanceService $balance,
        protected StockMovementService $movement,
        protected StockConsumptionService $consumption
    ) {}

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