<?php

namespace Modules\Inventory\Services\Inventory\Transaction;

use Modules\Inventory\Models\Sale;
use Modules\Inventory\Services\Inventory\BaseTransaction;


class SaleService extends BaseTransaction{
    protected string $type = 'sale';

   
    protected function modelClass()
    {
        return Sale::class;
    }

     protected function relationKey()
    {
        return 'sale_id';
    }


    protected function after($model, $items, $data, $totals, bool $isUpdate)
    {
      

        $accountData =  $this->tradingData($model, $data, $totals); 
        $accountData['sales_amount']        = $totals['subtotal'];
        $accountData['customer_advance']    = $totals['advance_adjusted'];
       
        $this->typeAccountResolver->resolve($this->type)->recordTransaction($accountData, $this->type);
        
    }
   

     protected function afterDelete($model): void
    {
        $deleteData = [
            'module'        => $this->type,
            'source'        => $this->type,
            'sourceId'      => $model->id,
            'reference_id'  => $model->id,
            'customer_id'   => $model->customer_id,
        ];

        $this->typeAccountResolver->resolve($this->type)->deleteEntry($deleteData);
    }

}