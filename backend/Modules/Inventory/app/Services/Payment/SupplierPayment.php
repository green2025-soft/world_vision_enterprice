<?php

namespace Modules\Inventory\Services\Payment;

use Modules\Inventory\Models\SupplierPayment as ModelsSupplierPayment;

class SupplierPayment extends BasePayment{
    protected function prefix(): string
    {
        return 'SDP-' . now()->format('ym') . '-';
    }

    private $type = 'supplier_payment';
   
    protected function modelClass()
    {
        return ModelsSupplierPayment::class;
    }

  

    protected function after($model, $data,  bool $isUpdate)
    {
        $accountData =  $this->paymentData($model, $data);

        $this->typeAccountResolver->resolve($this->type)->recordTransaction($accountData, $this->type);
        
    }

     protected function afterDelete($model): void
    {
        $deleteData = [
            'module'        => 'Supplier Due Payment',
            'source'        => 'Supplier Payment Voucher',
            'sourceId'      => $model->id,
            'reference_id'  => $model->id,
            'supplier_id'   => $model->supplier_id,
            'date'          => $model->payment_date,
        ];

        $this->typeAccountResolver->resolve($this->type)->deleteEntry($deleteData);
    }

}