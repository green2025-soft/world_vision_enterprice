<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;


use Illuminate\Http\Request;
use Modules\Inventory\Http\Requests\ProductWastageRequest;
use Modules\Inventory\Models\ProductWastage;


use Modules\Inventory\Services\Inventory\Transaction\ProductWastageService;

class ProductWastageController extends BaseApiController
{
    protected string $title = 'Product Wastage';

    protected ProductWastageService $productWastageService;

    public function __construct(ProductWastageService $productWastageService)
    {
        $this->productWastageService  = $productWastageService;
        $this->model = ProductWastage::class;
    }

    public function index(Request $request)
    {
         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(ProductWastageRequest $request)
    {
        $request->validated();
        if (empty($validated['wastage_no'])) {
            $request['wastage_no'] = $this->generateInvoiceNo();
        }
        if(!isset($request['']))

        $createData = $this->productWastageService->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
    }

        protected function generateInvoiceNo(): string
        {
            $prefix = 'WST-' . date('ym') . '-';

            $lastInvoiceNo = $this->model::where('wastage_no', 'like', $prefix . '%')
                ->latest('wastage_no')
                ->value('wastage_no');

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
        return $this->showData($id, ['items','items.product','items.currentStock', 'user']);

    }

    public function update(ProductWastageRequest $request, $id)
    {
        $request->validated();
        $updated = $this->productWastageService->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
    }

    public function destroy($id)
    {
        $this->productWastageService->delete($id);
        return $this->deletedResponse();
    }


    
}
