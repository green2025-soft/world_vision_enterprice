<?php

namespace Modules\Inventory\Services\Inventory\Transaction;

use Modules\Inventory\Models\Purchase;
use Modules\Inventory\Models\SaleReturn;
use Modules\Inventory\Services\Inventory\BaseTransaction;
use Modules\Inventory\Services\PriceListService;

class SaleReturnService extends BaseTransaction{
    protected string $type = 'sale_return';

   
    protected function modelClass()
    {
        return SaleReturn::class;
    }

     protected function relationKey()
    {
        return 'sale_return_id';
    }

    protected function after($model, $items, $data, $totals, bool $isUpdate)
    {
        
    }

     protected function afterDelete($model): void
    {
        // $this->transactionAccounting->delete($model->id, $this->type);
    }

}