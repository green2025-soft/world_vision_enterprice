<?php

namespace Modules\Inventory\Services\Inventory\Stock;

use Carbon\Carbon;
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
            ->whereBetween('created_at',[Carbon::parse($filters['from_date'])->startOfDay(), Carbon::parse($filters['to_date'])->endOfDay()])
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


    public function getProductLedger(array $filters)
    {
        $productId = $filters['product_id'];
         $product = Product::where('id', $productId)->with([
                'category:id,name',
                'brand:id,name',
                'unit:id,name',
            ])->first();
            

        // Opening
        $opening = StockMovement::query()
            ->where('product_id', $productId)
            ->where('branch_id', $filters['branch_id'])
            ->whereDate('created_at', '<', $filters['from_date'])
            ->get();


        $openingQty = $opening->sum(function ($item) {

            if (StockType::isStockIn($item->movement_type)) {
                return $item->quantity;
            }

            if (StockType::isStockOut($item->movement_type)) {
                return -$item->quantity;
            }

            return 0;
        });


        // Movement list
        $movements = StockMovement::query()
            ->with([
                'product:id,name,sku,category_id,brand_id,unit_id',
                'product.category:id,name',
                'product.brand:id,name',
                'product.unit:id,name',
            ])
            ->where('product_id', $productId)
            ->where('branch_id', $filters['branch_id'])
            ->whereBetween('created_at', [
                Carbon::parse($filters['from_date'])->startOfDay(),
                Carbon::parse($filters['to_date'])->endOfDay()
            ])
            ->orderBy('created_at')
            ->get();


        $balance = $openingQty;


        $items = $movements->map(function ($movement) use (&$balance) {
            $isStockIn = StockType::isStockIn($movement->movement_type);

            $qty =  $isStockIn
                ? $movement->quantity
                : -$movement->quantity;


            $balance += $qty;

           

            return [
                'id'            => $movement->id,
                'date'          => dbDateFormat($movement->created_at),
                'created_at'    => $movement->created_at,
                'type'          => $movement->movement_type,
                'type_name'     => StockType::getTypeName($movement->movement_type),
                'quantity'      => $movement->quantity,
                'in_out_qty'    => $qty,
                'is_stock_in'   => $isStockIn,
                'balance'       => $balance,
                'product'       => $movement->product,
            ];
        });


        return [
            'product' => $product,
            'opening' => [
                'quantity' => $openingQty
            ],

            'items' => $items,

            'closing' => [
                'quantity' => $balance
            ]
        ];
    }



}