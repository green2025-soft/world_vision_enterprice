<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\SupplierAdvance;
use Modules\Inventory\Http\Requests\SupplierAdvanceRequest;
use Illuminate\Http\Request;
use Modules\Inventory\Models\SupplierLedger;
use Modules\Inventory\Services\SupplierAdvanceService;

class SupplierAdvanceController extends BaseApiController
{
    protected string $title = 'Supplier Advance';

    protected SupplierAdvanceService $supplierAdvanceService;

    public function __construct(SupplierAdvanceService $supplierAdvanceService)
    {
        $this->model = SupplierAdvance::class;
        $this->supplierAdvanceService = $supplierAdvanceService;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])->with('supplier:id,name,phone');

        return $this->listResponse($query->smartPaginate());
    }

    public function store(SupplierAdvanceRequest $request)
    {
        $request->validated();

        $supplierId = $request->input('supplier_id');
        $balance = $this->supplierBalance($supplierId, true);

         if ($balance < 0) {
            return $this->error("This supplier has due. Advance cannot be given.", 422);
        }
        $createData = $this->supplierAdvanceService->createWithAccounting($request->all());
        return $this->createdResponse($createData);
        
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(SupplierAdvanceRequest $request, SupplierAdvance $supplier_advance)
    {
        $request->validated();

        $newAmount = $request['advance_amount'];
        $oldAmount = $supplier_advance->advance_amount;

        $balance = $this->supplierBalance($supplier_advance->supplier_id, true);

        $adjustedAmount = $oldAmount - $balance;

        if ($adjustedAmount > $newAmount) {
            return $this->error( "Already adjusted {$adjustedAmount}. You can't set advance lower than that.", 422);
        }

        $updated = $this->supplierAdvanceService->updateWithAccounting($supplier_advance, $request->all());

        return $this->updatedResponse($updated);
    }

    public function destroy(SupplierAdvance $supplier_advance)
    {
        $oldAmount = $supplier_advance->advance_amount;
        $balance = $this->supplierBalance($supplier_advance->supplier_id, true);

        $adjustedAmount =  $balance - $oldAmount;
        
        if ($adjustedAmount < 0) {
            return $this->error("Advance cannot be deleted because this supplier will become due.", 422);
        }
        
        $this->supplierAdvanceService->deleteWithAccounting($supplier_advance);
        return $this->deletedResponse();
    }

    public function supplierBalance($id, $isController=false){
        $leder = SupplierLedger::where('supplier_id', $id)
        ->selectRaw('SUM(debit) as total_debit, SUM(credit) as total_credit')
        ->first();

        $balance = ($leder->total_debit ?? 0) - ($leder->total_credit ?? 0);
        $leder->total_balance = $balance;
        $leder->status = $balance >= 0 ? 'advance' : 'due';
        if ($isController){
            return $balance;
        }

        return $this->successResponse($leder);
    }
    
}
