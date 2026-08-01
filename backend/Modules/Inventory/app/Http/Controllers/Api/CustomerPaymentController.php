<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;


use Illuminate\Http\Request;
use Modules\Inventory\Http\Requests\CustomerPaymentRequest;

use Modules\Inventory\Models\CustomerPayment as ModelsCustomerPayment;


use Modules\Inventory\Services\Payment\CustomerPayment;

class CustomerPaymentController extends BaseApiController
{
    protected string $title = 'Customer Payment';

    protected CustomerPayment $customerPayment;

    public function __construct(CustomerPayment $customerPayment)
    {
        $this->customerPayment  = $customerPayment;
        $this->model = ModelsCustomerPayment::class;
    }

    public function index(Request $request)
    {
         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('customer:id,name,phone,address')
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(CustomerPaymentRequest $request)
    {
        $request->validated();
       
        if(!isset($request['']))

        $createData = $this->customerPayment->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
    }



    public function show($id)
    {
        return $this->showData($id, ['customer', 'user']);

    }

    public function update(CustomerPaymentRequest $request, $id)
    {
        $request->validated();
        $updated = $this->customerPayment->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
    }

    public function destroy($id)
    {
        $this->customerPayment->delete($id);
        return $this->deletedResponse();
    }


    
}
