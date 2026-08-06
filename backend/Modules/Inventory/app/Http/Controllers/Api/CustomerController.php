<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Customer;
use Modules\Inventory\Http\Requests\CustomerRequest;
use Illuminate\Http\Request;
use Modules\Inventory\Models\CustomerLedger;
use Modules\Inventory\Services\CustomerPreviousDueService;
use Modules\Inventory\Services\LedgerService;

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
         $customerId = $request->input('customer_id');
         $id = $id??$customerId;
         
          $query = $this->indexQuery()
            ->where('branch_id', $branchId);
        if ($id){
            $query->where('id',$id); 
        }else{
          $query->where('status',1);  
        }
        $customers = $query->smartPaginate();
            //  Get supplier IDs for current page
        $customersIds = $customers->pluck('id')->toArray();

        //  Query 2: Fetch balances for only current page suppliers
        $balances = CustomerLedger::whereIn('customer_id', $customersIds)
        ->where('branch_id', $branchId)
        ->selectRaw('customer_id, SUM(debit - credit) as balance')
        ->groupBy('customer_id')
        ->get()
        ->keyBy('customer_id');
        
        // Attach balance to each supplier
        $customers->getCollection()->transform(function ($customer) use ($balances) {
            $customer->balance = $balances[$customer->id]->balance ?? 0;
            return $customer;
        });

     return $this->listResponse($customers);

    }

    public function ledger(Request $request, LedgerService $service)
    {
        $request->validate([
            'customer_id' => 'required|integer|min:1',
            'branch_id'   => 'required|integer|min:1',
            'from_date'   => 'required|date',
            'to_date'     => 'required|date|after_or_equal:from_date',
        ]);

        $filters = [
            'party_key' => 'customer_id',
            'party_id'  => $request->customer_id,
            'branch_id' => $request->branch_id,
            'from_date' => $request->from_date,
            'to_date'   => $request->to_date,
        ];
        $data = $service->getLedger(
            CustomerLedger::class,
            $filters
        );

        return $this->successResponse($data);
        
    }

    public function customerDueList(Request $request)
    {
        $branchId = $request->input('branch_id');
        $customerId = $request->input('customer_id');

        $customers = $this->indexQuery()
            ->where('branch_id', $branchId)
            ->where('status', 1)
            ->when($customerId, function ($query) use ($customerId) {
                $query->where('id', $customerId);
            })
            ->withSum([
                'ledgers as debit_total' => function ($query) use ($branchId) {
                    $query->where('branch_id', $branchId);
                }
            ], 'debit')
            ->withSum([
                'ledgers as credit_total' => function ($query) use ($branchId) {
                    $query->where('branch_id', $branchId);
                }
            ], 'credit')
            ->smartPaginate();

        $customers->getCollection()->transform(function ($customer) {
            $customer->balance = ($customer->debit_total ?? 0) - ($customer->credit_total ?? 0);
            return $customer;
        });

        $customers->setCollection(
            $customers->getCollection()->filter(function ($customer) {
                return $customer->balance > 0;
            })->values()
        );

        return $this->listResponse($customers);
    }



}
