<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;


use Illuminate\Http\Request;
use Modules\Inventory\Http\Requests\StockTransferRequest;
use Modules\Inventory\Models\StockTransfer;

use Modules\Inventory\Services\Inventory\Transaction\StockTransferService;

class StockTransferController extends BaseApiController
{
    protected string $title = 'Stock Transfer';

    protected StockTransferService $stockTransferService;

    public function __construct(StockTransferService $stockTransferService)
    {
        $this->stockTransferService  = $stockTransferService;
        $this->model = StockTransfer::class;
    }

    public function index(Request $request)
    {
         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('supplier:id,name,phone,address')
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(StockTransferRequest $request)
    {
        $request->validated();
        if (empty($validated['transfer_no'])) {
            $request['transfer_no'] = $this->generateInvoiceNo();
        }
        if(!isset($request['']))

        $createData = $this->stockTransferService->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
    }

        protected function generateInvoiceNo(): string
        {
            $prefix = 'TRF-' . date('ym') . '-';

            $lastInvoiceNo = $this->model::where('transfer_no', 'like', $prefix . '%')
                ->latest('transfer_no')
                ->value('transfer_no');

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
        return $this->showData($id, ['items','items.product','items.currentStock', 'supplier', 'purchase']);

    }

    public function update(StockTransferRequest $request, $id)
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
