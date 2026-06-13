<?php

namespace Modules\Inventory\Services\Payment;

use Modules\Inventory\Models\CustomerPayment as ModelsCustomerPayment;

class CustomerPayment extends BasePayment{
    protected function prefix(): string
    {
        return 'CDP-' . now()->format('ym') . '-';
    }

   
    private $type = 'customer_payment';

    protected function modelClass()
    {
        return ModelsCustomerPayment::class;
    }

  

    protected function after($model, $data,  bool $isUpdate)
    {
       $accountData =  $this->paymentData($model, $data);
        $this->typeAccountResolver->resolve($this->type)->recordTransaction($accountData, $this->type);
        
    }

     protected function afterDelete($model): void
    {
        $deleteData = [
            'module'        => 'Customer Due Payment',
            'source'        => 'Customer Payment Voucher',
            'sourceId'      => $model->id,
            'reference_id'  => $model->id,
            'customer_id'   => $model->customer_id,
            'date'          => $model->payment_date,
        ];

        $this->typeAccountResolver->resolve($this->type)->deleteEntry($deleteData);
    }

}