<?php 

namespace Modules\Inventory\Services;

use Modules\Inventory\Models\PriceList;


class PriceListService
{
    /**
     * Update price lists from purchased items.
     *
     * @param array $items
     * @param int|null $branchId
     * @return void
     */
    public function updatePrices(array $items, ?int $branchId = null, string $priceType='purchase'): void
    {
        foreach ($items as $item) {
            $now = now();

            // Expire previous  price
            $this->expireOldPrices($item['product_id'], $priceType, $branchId);

            PriceList::updateOrCreate(
                [
                    'product_id' => $item['product_id'],
                    'branch_id'  => $branchId,
                    'price_type' => 'purchase',
                    'start_date' => $now->toDateString(),
                ],
                [
                    'price'      => $item['unit_price'],
                    'end_date'   => null,
                    'remarks'    => 'Updated from '.$priceType,
                ]
            );

            if (!empty($item['sale_price'])) {
                $this->expireOldPrices($item['product_id'], 'sale', $branchId);

                PriceList::updateOrCreate(
                    [
                        'product_id' => $item['product_id'],
                        'branch_id'  => $branchId,
                        'price_type' => 'sale',
                        'start_date' => $now->toDateString(),
                    ],
                    [
                        'price'    => $item['sale_price'],
                        'end_date' => null,
                        'remarks'  => 'Updated from '.$priceType,
                    ]
                );
            }
        }
    }



    protected function expireOldPrices(int $productId, string $priceType, ?int $branchId = null)
    {
        PriceList::where('product_id', $productId)
            ->where('price_type', $priceType)
            ->when($branchId, fn ($q) => $q->where('branch_id', $branchId))
            ->whereNull('end_date')
            ->update(['end_date' => now()]);
    }

}

