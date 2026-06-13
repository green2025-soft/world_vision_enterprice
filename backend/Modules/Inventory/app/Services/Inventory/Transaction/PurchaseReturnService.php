<?php

namespace Modules\Inventory\Services\Inventory\Transaction;

use Modules\Inventory\Models\PurchaseReturn;
use Modules\Inventory\Services\Inventory\BaseTransaction;


class PurchaseReturnService extends BaseTransaction{
    protected string $type = 'purchase_return';

   
    protected function modelClass()
    {
        return PurchaseReturn::class;
    }

     protected function relationKey()
    {
        return 'purchase_return_id';
    }

    protected function after($model, $items, $data, $totals, bool $isUpdate)
    {
        $accountData = $this->returnData($model, $data, $totals);
    
        
        $accountData['purchase_return']            = $totals['total_return_amount'];
        $accountData['purchase_adjustment']        = $totals['wastage_amount_purchase'];
        
        $accountData['supplier_advance']        = $totals['supplier_advance'];
        $accountData['advance']                 = $totals['supplier_advance'];
        
        $this->typeAccountResolver->resolve($this->type)->recordTransaction($accountData, $this->type);
        
    }

     protected function afterDelete($model): void
    {
        $deleteData = [
            'module'        => $this->type,
            'source'        => 'Return',
            'sourceId'      => $model->id,
            'reference_id'  => $model->id,
            'supplier_id'   => $model->supplier_id,
        ];

        $this->typeAccountResolver->resolve($this->type)->deleteEntry($deleteData);
    }

}