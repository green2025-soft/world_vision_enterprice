<?php

namespace Modules\Inventory\Services\Inventory\Stock;

use Modules\Inventory\Models\Product;
use Modules\Inventory\Models\StockMovement;


class StockReportService
{


    public function getStockReport(array $filters)
    {

        $query = $this->buildQuery($filters);

        $summaryData    = (clone $query)->get();
        $summary        = $this->makeSummary($summaryData);
        $collection     = $query->smartPaginate();
        $collection->getCollection()->transform(function ($item) {
            $item->balance = $item->opening_qty + $item->stock_in - $item->stock_out;
            return $item;
        });
        $extra = [
            'summary'           => $summary,
            'perpageSummary'    => $this->makeSummary($collection)

        ];
        $response = $this->paginated($collection);
        return array_merge($response, $extra);

    }

     public function getProductStock(array $filters)
    {
        return $this->buildQuery($filters)->first();
    }


    protected function buildQuery(array $filters)
    {
        $branchId = $filters['branch_id'];
        $fromDate = $filters['from_date'];
        $toDate   = $filters['to_date'];

        return Product::query()
            ->select(['id','name','sku', 'image', 'category_id', 'unit_id', 'brand_id'])
            ->with([
                'category:id,name',
                'unit:id,name,short_code',
                'brand:id,name'
            ])
            ->when(!empty($filters['product_id']),fn($q)=>
                    $q->where('id',$filters['product_id'])
            )
            ->addSelect([
                'opening_qty' => $this->openingQuery($filters)
            ])
            ->addSelect([
                'stock_in' => $this->stockInOutQuery($filters,StockType::stockIn())
            ])
            ->addSelect([
                'stock_out' => $this->stockInOutQuery($filters,StockType::stockOut())
            ]);

    }

     protected function openingQuery(array $filters)
    {

        return StockMovement::query()
            ->selectRaw("
            COALESCE(
                SUM(
                    CASE
                    WHEN movement_type IN ('".implode("','", StockType::stockIn())."')
                    THEN quantity
                    WHEN movement_type IN ('".implode("','", StockType::stockOut())."')
                    THEN -quantity
                    ELSE 0
                    END
                ),0
            )
        ")
            ->whereColumn('product_id','inv_products.id')
            ->where('branch_id',$filters['branch_id'])
            ->whereDate('created_at','<',$filters['from_date']);
    }


    protected function stockInOutQuery(array $filters, array $types){
        return StockMovement::query()
        ->selectRaw("COALESCE(SUM(quantity),0)")
            ->whereColumn('product_id','inv_products.id')
            ->where('branch_id',$filters['branch_id'])
            ->whereBetween('created_at',[$filters['from_date'],$filters['to_date']])
            ->whereIn('movement_type',$types);
    }



    public function makeSummary($products)
    {
        $opening    = $products->sum('opening_qty');
        $stockIn    = $products->sum('stock_in');
        $stockOut   = $products->sum('stock_out');

        return [
            'opening_qty'   => (float)$opening,
            'stock_in'      => (float)$stockIn,
            'stock_out'     => (float)$stockOut,
            'closing_qty'   => (float)($opening + $stockIn - $stockOut)

        ];

    }

    public function paginated($collection)
    {
        if ($collection instanceof \Illuminate\Contracts\Pagination\Paginator) {
            return [
                'pagination' => [
                    'total'         => $collection->total(),
                    'per_page'      => $collection->perPage(),
                    'current_page'  => $collection->currentPage(),
                    'last_page'     => $collection->lastPage(),
                ],
                'items' => $collection->items()
            ];
        }

        // Fallback for empty or incorrect data — use default pagination metadata
        return [
            'pagination' => [
                'total'         => 0,
                'per_page'      => 0, 
                'current_page'  => 1,
                'last_page'     => 1,
            ],
            'items' => []
        ];
    }


}