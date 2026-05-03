<?php 

namespace Modules\Inventory\Core\Strategy;

use Modules\Inventory\Models\StockMovement;

class LIFO
{
    public function allocate(int $productId, float $qty, ?int $branchId = null): array
    {
        $remaining = $qty;
        $result = [];

        $batches = StockMovement::where('product_id', $productId)
            ->whereIn('movement_type', ['purchase', 'sale_return'])
            ->when($branchId, fn($q) => $q->where('branch_id', $branchId))
            ->orderBy('created_at', 'desc') // LIFO RULE
            ->get();

        foreach ($batches as $batch) {

            $available = $batch->quantity - ($batch->consumed_quantity ?? 0);

            if ($available <= 0) continue;

            $consume = min($available, $remaining);

            $batch->increment('consumed_quantity', $consume);

            $result[] = [
                'source_movement_id' => $batch->id,
                'product_id'         => $productId,
                'quantity'           => $consume,
                'unit_price'         => $batch->unit_price
            ];

            $remaining -= $consume;

            if ($remaining <= 0) break;
        }

        if ($remaining > 0) {
            throw new \Exception("LIFO: Insufficient stock for product {$productId}");
        }

        return $result;
    }
}