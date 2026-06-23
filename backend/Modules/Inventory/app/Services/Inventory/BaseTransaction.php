<?php 
namespace Modules\Inventory\Services\Inventory;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Services\Accounts\TypeAccountResolver;
use Modules\Inventory\Services\Inventory\Calculation\CalculationService;
use Modules\Inventory\Services\Inventory\Stock\StockService;
use Modules\Inventory\Services\Inventory\Transaction\ItemService;


abstract class BaseTransaction {

    protected string $type;

    public function __construct(
        protected TypeAccountResolver $typeAccountResolver
    ) {}

     protected function modelClass() {}


     protected function relationKey() {}

     public function storeOrUpdate(array $data, ?int $id = null)
    {
        return DB::transaction(function () use ($data, $id) {
            
             // 1. CALCULATION
            $calc = app(CalculationService::class)->calculate(
                $data['items'],
                $data,
                $this->type, 
            );

            $items  = $calc['items'];
            $totals = $calc['totals'];

            $model = $id
                ? $this->update($id, $data, $totals)
                : $this->create($data, $totals);

            // 3. ITEM SAVE (ONLY DB LAYER)
            app(ItemService::class)->replace(
                $model,
                $items,
                $this->relationKey()
            );

             // 4. STOCK ENGINE
            app(StockService::class)->handle(
                $this->type,
                $model,
                $items
            );

            // 5. POST ACTION (ACCOUNTING ETC)
            $this->after($model, $items, $data, $totals, $id !== null);

             return $model;

        });
    }


    protected function create(array $data, array $totals)
    {
        $class = $this->modelClass();

        return $class::create(array_merge($data, $totals, [
            'created_by' => auth()->id(),
        ]));

    }


    protected function update(int $id, array $data, array $totals)
    {
        $class = $this->modelClass();

        $model = $class::with('items')->findOrFail($id);

        $model->update(array_merge($data, $totals));

        return $model;
    }


    protected function after($model, $items, $data, $totals, bool $isUpdate)
    {
        // override in child
    }

    public function delete(int $id): void
    {
        DB::transaction(function () use ($id) {
            $class = $this->modelClass();
            $model = $class::with('items')->findOrFail($id);
            // \Log::debug($this->type);
            
            app(StockService::class)
                ->reverse($this->type, $model->id, $model);

            // $this->transactionAccounting->delete($model->id, $this->type);

            $this->afterDelete($model);
            $model->items()->delete();
            $model->delete();

        });
    }

    protected function afterDelete($model): void
    {
        
    }

    protected function tradingComondData($model, $data, $totals){
        $data['reference_id'] = $model->id;
        $data['reference_no'] = $model->invoice_no;
        return $data;
    }

    protected function tradingData($model, $data, $totals){
        $tradingData = $this->tradingComondData($model, $data, $totals);
        $tradingData['amount']              = $totals['net_total'];
        $tradingData['subtotal']            = $totals['subtotal'];

        $tradingData['paid_amount']         = $totals['paid_amount'];
        $tradingData['due_amount']          = $totals['due_amount'];
        $tradingData['tax_amount']          = $totals['total_tax'];
        $tradingData['discount_amount']     = $totals['total_discount'];
        $tradingData['inventory']           = $totals['inventory_subtotal'];
        $tradingData['cash_return']         = $totals['inventory_subtotal'];
        $tradingData['cogs']                = $totals['inventory_subtotal'];
        $tradingData['adjustment']          = $totals['adjustment'];

        return $tradingData;
    }

    protected function returnData($model, $data, $totals){
        $tradingData = $this->tradingComondData($model, $data, $totals);
        $cashRefund = $totals['cash_refund_amount'];
        $tradingData['amount']                  = $cashRefund;
        $tradingData['inventory']            = $totals['inventory'];

        $tradingData['stock_wastage']           = $totals['wastage_amount'];
        $tradingData['due_adjusted']            = $totals['adjusted_due_amount'];
        $tradingData['cash_return']             = $cashRefund;
 
        $tradingData['returned_stock']          = $totals['returned_stock'];
        $tradingData['inventory_wastage']       = $totals['wastage_amount'];
        

        $tradingData['adjusted_due_amount']     = $cashRefund;
        $tradingData['cash_refund_amount']      = $cashRefund;

         return $tradingData;
    }





}