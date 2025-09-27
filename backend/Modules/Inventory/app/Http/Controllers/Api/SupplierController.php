<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Supplier;
use Modules\Inventory\Http\Requests\SupplierRequest;
use Illuminate\Http\Request;
use Modules\Inventory\Models\SupplierLedger;
use Modules\Inventory\Services\SupplierPreviousDueService;

class SupplierController extends BaseApiController
{

     protected SupplierPreviousDueService $supplierPreviousDueService;
    protected string $title = 'Supplier';

    public function __construct(SupplierPreviousDueService $supplierPreviousDueService)
    {
        $this->supplierPreviousDueService = $supplierPreviousDueService;
        $this->model = Supplier::class;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id']);

        return $this->listResponse($query->smartPaginate());
    }

    public function store(SupplierRequest $request)
    {
        $request->validated();
        $request['previous_due'] = $request['previous_due']?$request['previous_due']:0.00;
        $createData = $this->supplierPreviousDueService->createWithAccounting($request->all());
        return $this->createdResponse($createData);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(SupplierRequest $request, Supplier $supplier)
    {
        $request->validated();
        
        $updated = $this->supplierPreviousDueService->updateWithAccounting($supplier, $request->all());
        return $this->updatedResponse($updated);
    }

    public function destroy(Supplier $supplier)
    {
        $this->supplierPreviousDueService->deleteWithAccounting($supplier);
        return $this->deletedResponse();
    }

 
}
