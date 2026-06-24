<?php

namespace Modules\Inventory\Services\Inventory\Transaction;


use Modules\Inventory\Models\StockTransfer;
use Modules\Inventory\Services\Inventory\BaseTransaction;


class StockTransferService extends BaseTransaction{
    protected string $type = 'transfer';

   
    protected function modelClass()
    {
        return StockTransfer::class;
    }

     protected function relationKey()
    {
        return 'stock_transfer_id';
    }

    protected function after($model, $items, $data, $totals, bool $isUpdate)
    {
        
    
        /**
         * FROM BRANCH
         Dr  Goods in Transit (10009)
         Cr  Inventory (10005)
         TO BRANCH
         Dr  Inventory (10005)
         Cr  Goods in Transit (10009)
         */
        $accountData = $this->returnData($model, $data, $totals);
        
        
        $accountData['purchase_return']             = $totals['total_refund_amount'];
        $accountData['purchase_adjustment']         = $totals['demurrage_stock'];
        
        $accountData['supplier_advance']            = $totals['supplier_advance'];
        $accountData['advance']                     = $totals['supplier_advance'];
        $accountData['adjusted_due_amount ']        = $totals['supplier_advance'];
        $accountData['inventory_shrinkage_loss']    = $totals['demurrage_stock'];
        
        
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