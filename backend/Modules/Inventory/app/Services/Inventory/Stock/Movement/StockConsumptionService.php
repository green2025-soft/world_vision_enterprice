<?php

namespace Modules\Inventory\Services\Inventory\Stock\Movement;

use Modules\Inventory\Models\StockMovement;
use Exception;

class StockConsumptionService
{
    protected string $strategy = 'fifo';

    protected array $stockInTypes = ['purchase', 'sale_return'];

    public function consume(int $productId, float $qty, int $branchId): void
    {
        $remaining = $qty;

        $batches = StockMovement::where('product_id', $productId)
            ->whereIn('movement_type', $this->stockInTypes)
            ->whereColumn('consumed_quantity', '<', 'quantity')
            ->where('branch_id', $branchId)
            ->orderBy('created_at', $this->strategy === 'fifo' ? 'asc' : 'desc')
            ->get();
            

        foreach ($batches as $batch) {

            $available = $batch->quantity - $batch->consumed_quantity;

            if ($available <= 0) continue;

            $use = min($available, $remaining);

            $batch->consumed_quantity += $use;
            $batch->save();

            $remaining -= $use;

            if ($remaining <= 0) break;
        }

        if ($remaining > 0) {
            throw new Exception("Insufficient FIFO stock for product ID: {$productId}");
        }
    }


    public function restore(int $productId, float $qty, int $branchId): void
    {
        $remaining = $qty;

        $batches = StockMovement::where('product_id', $productId)
            ->whereIn('movement_type', $this->stockInTypes)
            ->where('consumed_quantity', '>', 0)
            ->where('branch_id', $branchId)
            ->orderBy('created_at', 'desc') //  LIFO reverse
            ->get();

        foreach ($batches as $batch) {

            $used = $batch->consumed_quantity;

            if ($used <= 0) continue;

            $restore = min($used, $remaining);

            $batch->consumed_quantity -= $restore;
            $batch->save();

            $remaining -= $restore;

            if ($remaining <= 0) break;
        }

        if ($remaining > 0) {
            throw new Exception("Cannot restore more than sold quantity");
        }
    }
}