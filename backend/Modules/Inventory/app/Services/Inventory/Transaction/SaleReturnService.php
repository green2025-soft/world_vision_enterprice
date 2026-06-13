<?php

namespace Modules\Inventory\Services\Inventory\Transaction;

use Modules\Inventory\Models\SaleReturn;
use Modules\Inventory\Services\Inventory\BaseTransaction;


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
    
        $accountData =  $data;
        $accountData['amount']                  = $totals['cash_refund_amount'];

        $accountData['total_refund_amount']     = $totals['total_refund_amount'];
        $accountData['sales_return']            = $totals['total_return_amount'];
        $accountData['sales_adjustment']        = $totals['wastage_amount_sale'];
        $accountData['inventory']               = $totals['inventory'];
        $accountData['stock_wastage']           = $totals['wastage_amount'];
        $accountData['due_adjusted']            = $totals['adjusted_due_amount'];
        $accountData['cash_return']             = $totals['cash_refund_amount'];
        $accountData['customer_advance']        = $totals['customer_advance'];
        $accountData['advance']                 = $totals['customer_advance'];
        $accountData['returned_stock']          = $totals['inventory'];
        $accountData['inventory_wastage']       = $totals['wastage_amount'];
        

        $accountData['adjusted_due_amount']     = $totals['cash_refund_amount'];
        $accountData['cash_refund_amount']      = $totals['cash_refund_amount'];
        $accountData['reference_id']            = $model->id;
        $accountData['reference_no']            = $model->invoice_no;

        $this->typeAccountResolver->resolve($this->type)->recordTransaction($accountData, $this->type);
        
    }

     protected function afterDelete($model): void
    {
        $deleteData = [
            'module'        => $this->type,
            'source'        => 'Return',
            'sourceId'      => $model->id,
            'reference_id'  => $model->id,
            'customer_id'   => $model->customer_id,
        ];

        $this->typeAccountResolver->resolve($this->type)->deleteEntry($deleteData);
    }

}