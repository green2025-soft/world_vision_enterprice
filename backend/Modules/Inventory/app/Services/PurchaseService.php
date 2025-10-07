<?php

namespace Modules\Inventory\Services;


use Modules\Inventory\Models\Purchase;
use Modules\Inventory\Models\PurchaseItem;

use Modules\Inventory\Services\StockBalanceService;
use Modules\Inventory\Services\PriceListService;


class PurchaseService extends BaseInventoryService{

     public function __construct()
    {
        parent::__construct('purchase', Purchase::class);
    }

     protected function getItemsForeignKey(): string
    {
        return 'purchase_id';
    }

    protected function getItemsModel()
    {
        return PurchaseItem::class;
    }

    protected function afterStockHandling($model, array $itemsData, array $validated, array $totals, bool $isUpdate)
    {
        app(StockBalanceService::class)->updateFromPurchase($itemsData, $model->branch_id);
        app(PriceListService::class)->updatePrices($itemsData);
    }

}
