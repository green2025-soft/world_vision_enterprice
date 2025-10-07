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
            ->where('branch_id', $request['branch_id']);

        return $this->listResponse($query->smartPaginate());
    }

    public function store(PurchaseRequest $request)
    {
        $request->validated();
        if (empty($validated['invoice_no'])) {
            $validated['invoice_no'] = $this->generateInvoiceNo();
        }
        $createData = $this->purchaseService->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
        
    }

    protected function generateInvoiceNo(): string
    {
        // Example: INV-2025-10-0001 (date + increment)
        $prefix = 'INV-' . date('Y-m-d') . '-';

        // Get last invoice_no for today, extract last number, increment
        $lastInvoice = $this->model::where('invoice_no', 'like', $prefix . '%')
            ->orderBy('invoice_no', 'desc')
            ->first();

        if (!$lastInvoice) {
            return $prefix . '0001';
        }

        $lastNumber = (int)substr($lastInvoice->invoice_no, strlen($prefix));
        $newNumber = str_pad($lastNumber + 1, 4, '0', STR_PAD_LEFT);

        return $prefix . $newNumber;
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
