<?php

namespace Modules\Inventory\Services;



use Modules\Inventory\Models\Sale;
use Modules\Inventory\Models\SaleItem;
use Modules\Inventory\Services\StockBalanceService;
use Modules\Inventory\Services\PriceListService;

   
class SaleService extends BaseInventoryService{

     public function __construct()
    {
        parent::__construct('sale', Sale::class);
    }

     protected function getItemsForeignKey(): string
    {
        return 'sale_id';
    }

    protected function getItemsModel()
    {
        return SaleItem::class;
    }

    protected function afterStockHandling($model, array $itemsData, array $validated, array $totals, bool $isUpdate)
    {
        app(StockBalanceService::class)->updateFromPurchase($itemsData, $model->branch_id);
        app(PriceListService::class)->updatePrices($itemsData, $model->branch_id);
        
        if ($isUpdate){
            app(CustomerAccountingService::class)->deleteEntry($model->id, 'sale');
        }

        $paidAmount       = $totals['paid_amount'] ?? 0;
        $advanceAdjusted  = $totals['advance_adjusted'] ?? 0;
        $dueAmount        = $totals['due_amount'] ?? 0;


    
        app(CustomerAccountingService::class)->recordTransaction([
            'customer_id'       => $validated['customer_id'],

            'amount'            => $totals['due_amount'],
            'paid_amount'       => $paidAmount ?? 0,
            'customer_advance'  => $advanceAdjusted ?? 0,
            'tax_amount'        => $totals['total_tax_amount'] ?? 0,
            'discount_amount'   => $totals['total_discount'] ?? 0,
            'due_amount'        => $dueAmount ?? 0,
            'inventory'         => $totals['inventory'] ?? 0,
            'cogs'              => $totals['inventory'] ?? 0,
            'sales_revenue'     => $totals['total_unit_price'] ?? 0,

            'date'              => $validated['date'] ?? now(),
            'reference_id'      => $model->id,
            'reference_no'      => $model->invoice_no ?? null,
            'note'              => $validated['note'] ?? null,
            'branch_id'         => $validated['branch_id'],
        ], 'sale');

    }

    protected function afterDelete($model): void
    {
        app(CustomerAccountingService::class)->deleteEntry($model->id, 'sale');
    }

}
