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
        app(PriceListService::class)->updatePrices($itemsData, $model->branch_id);
        // dd($totals);
        if ($isUpdate){
            app(SupplierAccountingService::class)->deleteEntry($model->id, 'purchase');
        }

        // Step 3: Record Supplier Accounting Entry
        app(SupplierAccountingService::class)->recordTransaction([
            'supplier_id'       => $validated['supplier_id'],
            'amount'            => $totals['net_total'],
            'paid_amount'       => $totals['paid_amount'] ?? 0,
            'supplier_advance'  => $totals['advance_adjusted'] ?? 0,
            'tax_amount'        => $totals['tax_amount'] ?? 0,
            'discount_amount'   => $totals['discount_amount'] ?? 0,
            'due_amount'        => $totals['due_amount'] ?? 0,
            'inventory'         => $totals['inventory'] ?? 0,

            'date'              => $validated['date'] ?? now(),
            'reference_id'      => $model->id,
            'reference_no'      => $model->invoice_no ?? null,
            'note'              => $validated['note'] ?? null,
            'branch_id'         => $validated['branch_id'],
        ], 'purchase');

    }

    protected function afterDelete($model): void
    {
        app(SupplierAccountingService::class)->deleteEntry($model->id, 'purchase');
    }

}
