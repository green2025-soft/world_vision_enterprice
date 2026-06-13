<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;


use Illuminate\Http\Request;
use Modules\Inventory\Http\Requests\CustomerPaymentRequest;
use Modules\Inventory\Models\CustomerLedger;
use Modules\Inventory\Models\CustomerPayment as ModelsCustomerPayment;


use Modules\Inventory\Services\Payment\CustomerPayment;

class CustomerPaymentController extends BaseApiController
{
    protected string $title = 'Customer Payment';

    protected CustomerPayment $customerPayment;

    public function __construct(CustomerPayment $customerPayment)
    {
        $this->customerPayment  = $customerPayment;
        $this->model = ModelsCustomerPayment::class;
    }

    public function index(Request $request)
    {
         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('customer:id,name,phone,address')
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(CustomerPaymentRequest $request)
    {
        $request->validated();
       
        if(!isset($request['']))

        $createData = $this->customerPayment->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
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

    public function update(CustomerPaymentRequest $request, $id)
    {
        $request->validated();
        $updated = $this->customerPayment->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
    }

    public function destroy($id)
    {
        $this->customerPayment->delete($id);
        return $this->deletedResponse();
    }


    
}
