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
        $extra = [
            'supplier_id'       => $data['supplier_id'] ?? null,
            'supplier_advance'  => $totals['advance_adjusted'] ?? 0,
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
        $this->transactionAccounting->delete($model->id, $this->type);
    }

}