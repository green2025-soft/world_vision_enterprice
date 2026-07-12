<?php

namespace Modules\Inventory\Services\Inventory\Transaction;

use Modules\Accounting\Services\AccountingManagerService;
use Modules\Inventory\Models\ProductWastage;

use Modules\Inventory\Services\Inventory\BaseTransaction;


class ProductWastageService extends BaseTransaction{
    protected string $type = 'wastage';

   
    protected function modelClass()
    {
        return ProductWastage::class;
    }

     protected function relationKey()
    {
        return 'product_wastage_id';
    }

    protected function after($model, $items, $data, $totals, bool $isUpdate)
    {
        
        $accountData = [
            'inventory_wastage' => $totals['total_cost'],
            'stock_wastage'     => $totals['total_cost'],
            'branch_id'         => $data['branch_id'],
        ];
        
        $this->accountingService()->createEntryFromModule(
            moduleName: 'Product Wastage Voucher',
            sourceType: 'Product Wastage',
            sourceId: $model->id,
            data: $accountData
        );
        

        
    }

     protected function afterDelete($model): void
    {
       

         $this->accountingService()->deleteEntryFromModule(
             moduleName: 'Product Wastage Voucher',
            sourceType: 'Product Wastage',
            sourceId: $model->id,
        );
        
    }

     protected function accountingService(): AccountingManagerService
    {
        return app(AccountingManagerService::class);
    }

}