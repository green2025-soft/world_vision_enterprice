<?php

namespace Modules\Inventory\Services;

use Modules\Inventory\Models\PriceList;
use Illuminate\Support\Carbon;

class PriceListService
{
    /**
     * Update price lists from purchased items.
     *
     * @param array $items
     * @param int|null $branchId
     * @param string $priceType
     * @return void
     */
    public function updatePrices(array $items, ?int $branchId = null, string $priceType = 'purchase'): void
    {
        $now = now();

        foreach ($items as $item) {
            $this->updatePriceIfNeeded($item, 'unit_price', 'purchase', $branchId, $priceType, $now);
            $this->updatePriceIfNeeded($item, 'sale_price', 'sale', $branchId, $priceType, $now);
        }
    }

    /**
     * Update price if the new price is different and present.
     */
    protected function updatePriceIfNeeded(
        array $item,
        string $priceKey,
        string $priceType,
        ?int $branchId,
        string $sourcePriceType,
        Carbon $now
    ): void {
        if (empty($item[$priceKey])) {
            return;
        }

        $newPrice = floatval($item[$priceKey]);
        $productId = $item['product_id'];
        $remarks = 'Updated from ' . $sourcePriceType;

        $activePrice = $this->getActivePrice($productId, $priceType, $branchId);

        if (!$activePrice) {
            $this->createPriceList($productId, $branchId, $priceType, $newPrice, $remarks, $now);
            return;
        }

        if (floatval($activePrice->price) === $newPrice) {
            return;
        }

        $this->endCurrentPrice($activePrice, $now);
        $this->createPriceList($productId, $branchId, $priceType, $newPrice, $remarks, $now);
    }

    /**
     * Get active price record for given product, price type and branch.
     */
    protected function getActivePrice(int $productId, string $priceType, ?int $branchId)
    {
        return PriceList::where('product_id', $productId)
            ->where('price_type', $priceType)
            ->when($branchId, fn($q) => $q->where('branch_id', $branchId))
            ->whereNull('end_date')
            ->latest('start_date')
            ->first();
    }

    /**
     * Mark the current price list entry as ended (close the validity).
     */
    protected function endCurrentPrice(PriceList $priceList, Carbon $now): void
    {
        $priceList->update([
            'end_date' => $now->copy()->subDay()->toDateString()
        ]);
    }

    /**
     * Create a new price list entry.
     */
    protected function createPriceList(int $productId, ?int $branchId, string $priceType, float $price, string $remarks, Carbon $now): void
    {
        PriceList::create([
            'product_id' => $productId,
            'branch_id'  => $branchId,
            'price_type' => $priceType,
            'price'      => $price,
            'start_date' => $now->toDateString(),
            'remarks'    => $remarks,
        ]);
    }

    /**
     * Get latest purchase and sale prices with dates for a product.
     *
     * @param int $productId
     * @param int|null $branchId
     * @return array
     */
    public function getLatestPrices(int $productId, ?int $branchId = null): array
    {
        $baseQuery = PriceList::where('product_id', $productId)
            ->when($branchId, fn($q) => $q->where('branch_id', $branchId));

        $latestPurchase = (clone $baseQuery)
            ->where('price_type', 'purchase')
            ->latest('start_date')
            ->first();

        $latestSale = (clone $baseQuery)
            ->where('price_type', 'sale')
            ->latest('start_date')
            ->first();

        return [
            'purchase_price' => $latestPurchase?->price,
            'sale_price'     => $latestSale?->price,
            'purchase_date'  => $latestPurchase?->start_date,
            'sale_date'      => $latestSale?->start_date,
        ];
    }
}
