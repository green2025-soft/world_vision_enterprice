<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;


use Illuminate\Http\Request;
use Modules\Inventory\Http\Requests\SupplierPaymentRequest;

use Modules\Inventory\Models\SupplierPayment as ModelsSupplierPayment;


use Modules\Inventory\Services\Payment\SupplierPayment;

class SupplierPaymentController extends BaseApiController
{
    protected string $title = 'Supplier Payment';

    protected SupplierPayment $supplierPayment;

    public function __construct(SupplierPayment $supplierPayment)
    {
        $this->supplierPayment  = $supplierPayment;
        $this->model = ModelsSupplierPayment::class;
    }

    public function index(Request $request)
    {
         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('supplier:id,name,phone,address')
            ;

        return $this->listResponse($query->smartPaginate());
    }

    public function store(SupplierPaymentRequest $request)
    {
        $request->validated();
       
        if(!isset($request['']))

        $createData = $this->supplierPayment->storeOrUpdate($request->all());
        return $this->createdResponse($createData);
    }



       public function show($id)
    {
        return $this->showData($id, ['supplier', 'user']);

    }

    public function update(SupplierPaymentRequest $request, $id)
    {
        $request->validated();
        $updated = $this->supplierPayment->storeOrUpdate($request->all(), $id);
        return $this->updatedResponse($updated);
    }

    public function destroy($id)
    {
        $this->supplierPayment->delete($id);
        return $this->deletedResponse();
    }


    
}
