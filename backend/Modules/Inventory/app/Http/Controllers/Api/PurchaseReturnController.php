<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;


use Illuminate\Http\Request;
use Modules\Inventory\Http\Requests\PurchaseReturnRequest;
use Modules\Inventory\Models\CustomerLedger;
use Modules\Inventory\Models\PurchaseReturn;
use Modules\Inventory\Models\SupplierLedger;
use Modules\Inventory\Services\Inventory\Transaction\PurchaseReturnService;

class PurchaseReturnController extends BaseApiController
{
    protected string $title = 'Purchase Return';

    protected PurchaseReturnService $purchaseReturnService;

    public function __construct(PurchaseReturnService $purchaseReturnService)
    {
        $this->purchaseReturnService  = $purchaseReturnService;
        $this->model = PurchaseReturn::class;
    }

    public function index(Request $request)
    {
         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('supplier:id,name,phone,address')
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(PurchaseReturnRequest $request)
    {
        $request->validated();
        if (empty($validated['invoice_no'])) {
            $request['invoice_no'] = $this->generateInvoiceNo();
        }
        if(!isset($request['']))

        $createData = $this->purchaseReturnService->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
    }

        protected function generateInvoiceNo(): string
        {
            $prefix = 'PRT-' . date('ym') . '-';

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
        $sales = $this->model::with(['items.product','items.currentStock', 'supplier'])->findOrFail($id);
        $supplierBalance = SupplierLedger::where('supplier_id', $sales->supplier_id)
        ->where('branch_id', $sales->branch_id) 
        ->selectRaw('SUM(debit - credit) as balance')
        ->value('balance') ?? 0;
         // Attach balance to customer
        if ($sales->supplier) {
            $sales->supplier->balance = (float) $supplierBalance;
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

    public function update(PurchaseReturnRequest $request, $id)
    {
        $request->validated();
        $updated = $this->purchaseReturnService->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
    }

    public function destroy($id)
    {
        $this->purchaseReturnService->delete($id);
        return $this->deletedResponse();
    }


    
}
