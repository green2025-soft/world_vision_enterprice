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
            // ->where('from_branch_id', $request['from_branch_id'])
            // ->orWhere('to_branch_id', $request['to_branch_id'])
            ->with('fromBranch:id,name,contact_no', 'toBranch:id,name,contact_no')
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
        return $this->showData($id, ['fromBranch', 'toBranch', 'user','items','items.product','items.currentStock']);

    }

    public function update(StockTransferRequest $request, $id)
    {
        $request->validated();
        $updated = $this->stockTransferService->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
    }

    public function destroy($id)
    {
        $this->stockTransferService->delete($id);
        return $this->deletedResponse();
    }


    
}
