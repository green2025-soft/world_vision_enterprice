<?php

namespace Modules\Inventory\Services\Transaction;

use Modules\Inventory\Models\Sale;

class SaleService extends TransactionService{
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
        $extra = [
            'customer_id'       => $data['customer_id'] ?? null,
            'customer_advance'  => $totals['advance_adjusted'] ?? 0,
            'sales_revenue'     => $totals['subtotal'] ?? 0,
            'adjustment'        => $data['adjustment'] ?? 0,
        ];

        $this->transactionAccounting
            ->record(
                model: $model,
                data: $data,
                totals: $totals,
                context: [
                    'type'      => $this->type,
                    'extra'     => $extra 
                ],
                isUpdate: $isUpdate
            );
    }

     protected function afterDelete($model): void
    {
        // $this->transactionAccounting->delete($model->id, $this->type);
    }

}