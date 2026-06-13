<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Sale;
use Modules\Inventory\Http\Requests\SaleRequest;
use Illuminate\Http\Request;
use Modules\Inventory\Models\CustomerLedger;
use Modules\Inventory\Services\Inventory\Transaction\SaleService;

class SaleController extends BaseApiController
{
    protected string $title = 'Sale';

    protected SaleService $saleService;

    public function __construct(SaleService $saleService)
    {
        $this->saleService  = $saleService;
        $this->model = Sale::class;
    }

    public function index(Request $request)
    {
         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('customer:id,name,phone,address')
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(SaleRequest $request)
    {
        $request->validated();
        if (empty($validated['invoice_no'])) {
            $request['invoice_no'] = $this->generateInvoiceNo();
        }
        if(!isset($request['']))
            
        $createData = $this->saleService->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
    }

         protected function generateInvoiceNo(): string
        {
            $prefix = 'SAL-' . date('ym') . '-';

            $lastInvoiceNo = $this->model::where('invoice_no', 'like', $prefix . '%')
                ->latest('invoice_no')
                ->value('invoice_no');

            $nextNumber = 1;

            if ($lastInvoiceNo) {
                $lastNumber = (int) substr($lastInvoiceNo, strlen($prefix));
                $nextNumber = $lastNumber + 1;
            }

            $paddedNumber = str_pad($nextNumber, 4, '0', STR_PAD_LEFT);

            return $prefix . $paddedNumber;
        }

    public function show($id)
    {
        $sales = $this->model::with(['items.product','items.currentStock', 'customer', 'stockMovements'])->findOrFail($id);
        $customerBalance = CustomerLedger::where('customer_id', $sales->customer_id)
        ->where('branch_id', $sales->branch_id) 
        ->selectRaw('SUM(debit - credit) as balance')
        ->value('balance') ?? 0;
         // Attach balance to customer
        if ($sales->customer) {
            $sales->customer->balance = (float) $customerBalance;
        }


            $sales->items->transform(function ($item) use ($sales) {
            $consumedQuantity = $sales->stockMovements->where('product_id', $item->product_id)->sum('consumed_quantity');
                return [
                    'id'                => $item->id,
                    'product_id'        => $item->product_id,
                    'name'              => $item->product?->name,
                    'sku'               => $item->product?->sku,
                    'quantity'          => $item->quantity,
                    'purchase_price'    => $item->unit_price, 
                    'unit_price'        => $item->unit_price,
                    'cost_price'        => $item->cost_price,
                    'sale_price'        => $item->sale_price,
                    'current_stock'     => $item->currentStock?->current_stock,
                    'consumed_quantity' => $consumedQuantity,
                ];
            });

        return $this->successResponse($sales);

    }

    public function update(SaleRequest $request, $id)
    {
        $request->validated();
        $updated = $this->saleService->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
    }

    public function destroy($id)
    {
        $this->saleService->delete($id);
        return $this->deletedResponse();
    }


    public function invoiceItems(Request $request){
        $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with([
                'customer:id,name,phone,address',
                'items.product',
                'items.currentStock',
                'stockMovements'
            ]);
        if ($request->customer_id) {
            $query->where('customer_id', $request->customer_id);
        }

        $invoices = $query->smartPaginate();

        $invoices->getCollection()->transform(function ($invoice) {

            $consumedMap = $invoice->stockMovements
                ->groupBy('product_id')
                ->map(fn ($rows) => $rows->sum('consumed_quantity'));

            $invoice->items->transform(function ($item) use ($consumedMap) {
                $item->consumed_quantity = $consumedMap[$item->product_id] ?? 0;
                return $item;
            });

            return $invoice;
        });

        return $this->listResponse($invoices);
    }
}
