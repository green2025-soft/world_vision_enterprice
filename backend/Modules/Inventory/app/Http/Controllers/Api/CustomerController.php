<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Customer;
use Modules\Inventory\Http\Requests\CustomerRequest;
use Illuminate\Http\Request;
use Modules\Inventory\Models\CustomerLedger;
use Modules\Inventory\Services\CustomerPreviousDueService;

class CustomerController extends BaseApiController
{
    protected string $title = 'Customer';

     protected CustomerPreviousDueService $customerPreviousDueService;

    public function __construct(CustomerPreviousDueService $customerPreviousDueService)
    {
        $this->model = Customer::class;
        $this->customerPreviousDueService = $customerPreviousDueService;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id']);

        return $this->listResponse($query->smartPaginate());
    }

    public function store(CustomerRequest $request)
    {
        $request->validated();
         $request['previous_due'] = $request['previous_due']?$request['previous_due']:0.00;
         $createData = $this->customerPreviousDueService->createWithAccounting($request->all());
         return $this->createdResponse($createData);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(CustomerRequest $request, Customer $customer)
    {
        $request->validated();
        $updated = $this->customerPreviousDueService->updateWithAccounting($customer, $request->all());
        return $this->updatedResponse($updated);
    }

    public function destroy(Customer $customer)
    {
        $this->customerPreviousDueService->deleteWithAccounting($customer);
        return $this->deletedResponse();
    }


    public function getCustomerrBalances(Request $request, $id=null){
         $branchId = $request->input('branch_id');
          $query = $this->indexQuery()
            ->where('branch_id', $branchId);
        if ($id){
            $query->where('id',$id); 
        }else{
          $query->where('status',1);  
        }
        $customers = $query->smartPaginate();
            // ✅ Get supplier IDs for current page
        $customersIds = $customers->pluck('id')->toArray();

        // ✅ Query 2: Fetch balances for only current page suppliers
        $balances = CustomerLedger::whereIn('customer_id', $customersIds)
        ->where('customer_id', $branchId)
        ->selectRaw('customer_id, SUM(debit - credit) as balance')
        ->groupBy('customer_id')
        ->get()
        ->keyBy('customer_id');

        // ✅ Attach balance to each supplier
        $customers->getCollection()->transform(function ($customer) use ($balances) {
            $customer->balance = $balances[$customer->id]->balance ?? 0;
            return $customer;
        });

     return $this->listResponse($customers);


    }
}
