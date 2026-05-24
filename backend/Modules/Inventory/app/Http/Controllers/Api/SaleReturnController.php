<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;


use Illuminate\Http\Request;
use Modules\Inventory\Http\Requests\SaleReturnRequest;
use Modules\Inventory\Models\CustomerLedger;
use Modules\Inventory\Models\SaleReturn;
use Modules\Inventory\Services\Inventory\Transaction\SaleReturnService;

class SaleReturnController extends BaseApiController
{
    protected string $title = 'Sale Return';

    protected SaleReturnService $saleReturnService;

    public function __construct(SaleReturnService $saleReturnService)
    {
        $this->saleReturnService  = $saleReturnService;
        $this->model = SaleReturn::class;
    }

    public function index(Request $request)
    {
         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('customer:id,name,phone,address')
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(SaleReturnRequest $request)
    {
        $request->validated();
        if (empty($validated['invoice_no'])) {
            $request['invoice_no'] = $this->generateInvoiceNo();
        }
        if(!isset($request['']))

        $createData = $this->saleReturnService->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
    }

        protected function generateInvoiceNo(): string
        {
            $prefix = 'SRT-' . date('ym') . '-';

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
        $sales = $this->model::with(['items.product','items.currentStock', 'customer'])->findOrFail($id);
        $customerBalance = CustomerLedger::where('customer_id', $sales->customer_id)
        ->where('branch_id', $sales->branch_id) 
        ->selectRaw('SUM(debit - credit) as balance')
        ->value('balance') ?? 0;
         // Attach balance to customer
        if ($sales->customer) {
            $sales->customer->balance = (float) $customerBalance;
        }

            $sales->items->transform(function ($item) {
                return [
                    'id'            => $item->id,
                    'product_id'    => $item->product_id,
                    'name'          => $item->product?->name,
                    'sku'           => $item->product?->sku,
                    'quantity'      => $item->quantity,
                    'purchase_price' => $item->unit_price, 
                    'unit_price'    => $item->unit_price,
                    'cost_price'    => $item->cost_price,
                    'sale_price'    => $item->sale_price,
                    'current_stock' => $item->currentStock?->current_stock
                ];
            });

        return $this->successResponse($sales);

    }

    public function update(SaleReturnRequest $request, $id)
    {
        $request->validated();
        $updated = $this->saleReturnService->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
    }

    public function destroy($id)
    {
        $this->saleReturnService->delete($id);
        return $this->deletedResponse();
    }


    
}
