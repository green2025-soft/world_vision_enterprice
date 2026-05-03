<?php 
namespace Modules\Inventory\Services\Sale;

use Modules\Inventory\DTO\SaleDTO;
use Modules\Inventory\Core\Stock\StockEngine;
use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\Sale;

class SaleService
{
    public function __construct(
        private StockEngine $stockEngine
    ) {}

    public function store(SaleDTO $dto)
    {
        return DB::transaction(function () use ($dto) {

            $items = [];

            foreach ($dto->items as $item) {
                $items[] = [
                    'product_id' => $item->product_id,
                    'quantity'   => $item->quantity,
                    'unit_price' => $item->sale_price,
                ];
            }

            $sale = Sale::create([
                'customer_id'  => $dto->customer_id,
                'invoice_date' => $dto->invoice_date,
                'branch_id'    => $dto->branch_id,
                'total'        => collect($items)->sum(fn($i) => $i['quantity'] * $i['unit_price']),
                'paid_amount'  => $dto->paid_amount,
            ]);

            $this->stockEngine->process('sale', $sale, $items);

            return $sale;
        });
    }
}