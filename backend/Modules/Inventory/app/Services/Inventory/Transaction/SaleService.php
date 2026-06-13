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
        // \Log::debug( $totals);exit();
        
        $accountData =  $data;
        $accountData['amount']              = $totals['net_total'];
        $accountData['subtotal']            = $totals['subtotal'];

        $accountData['paid_amount']         = $totals['paid_amount'];
        $accountData['due_amount']          = $totals['due_amount'];
        $accountData['tax_amount']          = $totals['total_tax'];
        $accountData['discount_amount']     = $totals['total_discount'];
        $accountData['inventory']           = $totals['inventory_subtotal'];
        $accountData['cash_return']         = $totals['inventory_subtotal'];
        $accountData['cogs']                = $totals['inventory_subtotal'];
        $accountData['customer_advance']    = $totals['advance_adjusted'];
        $accountData['sales_revenue']       = $totals['subtotal'];
        $accountData['adjustment']          = $totals['adjustment'];

        $accountData['reference_id']        = $model->id;
        $accountData['reference_no']        = $model->invoice_no;

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