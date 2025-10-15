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

    public function supplier(Request $request){
        $branchId = $request['branch_id'];

         $query = $this->indexQuery()
            ->where('branch_id', $branchId);

        $products = $query->smartPaginate();

    }

    public function getSupplierBalances(Request $request, $id=null){
         $branchId = $request->input('branch_id');
          $query = $this->indexQuery()
            ->where('branch_id', $branchId);
        if ($id){
            $query->where('id',$id); 
        }else{
          $query->where('status',1);  
        }
        $suppliers = $query->smartPaginate();
            // ✅ Get supplier IDs for current page
        $supplierIds = $suppliers->pluck('id')->toArray();

        // ✅ Query 2: Fetch balances for only current page suppliers
        $balances = SupplierLedger::whereIn('supplier_id', $supplierIds)
        ->where('branch_id', $branchId)
        ->selectRaw('supplier_id, SUM(debit - credit) as balance')
        ->groupBy('supplier_id')
        ->get()
        ->keyBy('supplier_id');

        // ✅ Attach balance to each supplier
        $suppliers->getCollection()->transform(function ($supplier) use ($balances) {
            $supplier->balance = $balances[$supplier->id]->balance ?? 0;
            return $supplier;
        });

     return $this->listResponse($suppliers);


    }

 
}
