<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;


use Illuminate\Http\Request;
use Modules\Inventory\Http\Requests\SupplierPaymentRequest;
use Modules\Inventory\Models\SupplierLedger;
use Modules\Inventory\Models\SupplierPayment as ModelsSupplierPayment;


use Modules\Inventory\Services\Payment\SupplierPayment;

class SupplierPaymentController extends BaseApiController
{
    protected string $title = 'Supplier Payment';

    protected SupplierPayment $supplierPayment;

    public function __construct(SupplierPayment $supplierPayment)
    {
        $this->supplierPayment  = $supplierPayment;
        $this->model = ModelsSupplierPayment::class;
    }

    public function index(Request $request)
    {
         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('supplier:id,name,phone,address')
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(SupplierPaymentRequest $request)
    {
        $request->validated();
       
        if(!isset($request['']))

        $createData = $this->supplierPayment->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
    }



    public function show($id)
    {
        $sales = $this->model::with(['items.product','items.currentStock', 'supplier'])->findOrFail($id);
        $supplierBalance = SupplierLedger::where('supplier_id', $sales->supplier_id)
        ->where('branch_id', $sales->branch_id) 
        ->selectRaw('SUM(debit - credit) as balance')
        ->value('balance') ?? 0;
         // Attach balance to Supplier
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

    public function update(SupplierPaymentRequest $request, $id)
    {
        $request->validated();
        $updated = $this->supplierPayment->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
    }

    public function destroy($id)
    {
        $this->supplierPayment->delete($id);
        return $this->deletedResponse();
    }


    
}
