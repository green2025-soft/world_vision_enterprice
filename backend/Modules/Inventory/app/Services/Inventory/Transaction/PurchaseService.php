<?php

namespace Modules\Inventory\Services\Inventory\Transaction;

use Modules\Inventory\Models\Purchase;
use Modules\Inventory\Services\Inventory\BaseTransaction;
use Modules\Inventory\Services\PriceListService;

class PurchaseService extends BaseTransaction{
    protected string $type = 'purchase';

   
    protected function modelClass()
    {
        return Purchase::class;
    }

     protected function relationKey()
    {
        return 'purchase_id';
    }

    protected function after($model, $items, $data, $totals, bool $isUpdate)
    {
        app(PriceListService::class)->updatePrices($items, $data['branch_id']);

        $accountData =  $this->tradingData($model, $data, $totals); 
        $accountData['supplier_advance']    = $totals['advance_adjusted'];
       
        $this->typeAccountResolver->resolve($this->type)->recordTransaction($accountData, $this->type);
        
    }

     protected function afterDelete($model): void
    {

        $deleteData = [
            'module'        => $this->type,
            'source'        => $this->type,
            'sourceId'      => $model->id,
            'reference_id'  => $model->id,
            'purchase_id'   => $model->purchase_id,
        ];

        $this->typeAccountResolver->resolve($this->type)->deleteEntry($deleteData);

    }

}