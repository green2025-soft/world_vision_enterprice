<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Purchase;
use Modules\Inventory\Http\Requests\PurchaseRequest;
use Illuminate\Http\Request;
use Modules\Inventory\Services\PurchaseService;

class PurchaseController extends BaseApiController
{
    protected string $title = 'Purchase';

     protected PurchaseService $purchaseService;

    public function __construct(PurchaseService $purchaseService)
    {
        $this->purchaseService = $purchaseService;
        $this->model = Purchase::class;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('supplier:id,name,phone,address')
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(PurchaseRequest $request)
    {
        $request->validated();
        if (empty($validated['invoice_no'])) {
            $request['invoice_no'] = $this->generateInvoiceNo();
        }
        
        
        $createData = $this->purchaseService->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
        
    }

        protected function generateInvoiceNo(): string
        {
            $prefix = 'INV-' . date('Y-m') . '-';

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
        return $this->showData($id);
    }

    public function update(PurchaseRequest $request, $id)
    {
        $request->validated();
        $updated = $this->purchaseService->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
        

    }

    public function destroy($id)
    {
        $this->purchaseService->delete($id);
        return $this->deletedResponse();
    }
}
