<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\CustomerAdvance;
use Modules\Inventory\Http\Requests\CustomerAdvanceRequest;
use Illuminate\Http\Request;
use Modules\Inventory\Models\CustomerLedger;
use Modules\Inventory\Services\CustomerAdvanceService;

class CustomerAdvanceController extends BaseApiController
{
    protected string $title = 'Customer Advance';

     protected CustomerAdvanceService $customerAdvanceService;

    public function __construct(CustomerAdvanceService $customerAdvanceService)
    {
        $this->model = CustomerAdvance::class;
         $this->customerAdvanceService = $customerAdvanceService;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])->with('customer:id,name,phone');

        return $this->listResponse($query->smartPaginate());
    }

    public function store(CustomerAdvanceRequest $request)
    {
        $request->validated();
        $customerId = $request->input('customer_id');
        $balance = $this->customerBalance($customerId, true);
        

         if ($balance < 0) {
            return $this->error("This customer has due. Advance cannot be given.", 422);
        }
        
        $createData = $this->customerAdvanceService->createWithAccounting($request->all());

        return $this->createdResponse($createData);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(CustomerAdvanceRequest $request, CustomerAdvance $customer_advance)
    {
        $request->validated();
        $newAmount = $request['advance_amount'];
        $oldAmount = $customer_advance->advance_amount;
        $balance = $this->customerBalance($customer_advance->customer_id, true);
        $adjustedAmount = $oldAmount - $balance;

         if ($adjustedAmount > $newAmount) {
            return $this->error( "Already adjusted {$adjustedAmount}. You can't set advance lower than that.", 422);
        }

        $updated = $this->customerAdvanceService->updateWithAccounting($customer_advance, $request->all());

        return $this->updatedResponse($updated);
    }

    public function destroy(CustomerAdvance $customer_advance)
    {
        $oldAmount = $customer_advance->advance_amount;
        $balance = $this->customerBalance($customer_advance->customer_id, true);
        $adjustedAmount =  $balance - $oldAmount;
        if ($adjustedAmount < 0) {
            return $this->error("Advance cannot be deleted because this supplier will become due.", 422);
        }
        
        $this->customerAdvanceService->deleteWithAccounting($customer_advance);
        return $this->deletedResponse();
    }
    

     public function customerBalance($id, $isController=false){
        $leder = CustomerLedger::where('customer_id', $id)
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
