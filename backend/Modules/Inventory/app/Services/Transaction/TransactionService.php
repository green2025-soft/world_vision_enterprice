<?php

namespace Modules\Inventory\Services\Transaction;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Services\Calculation\CalculationService;
use Modules\Inventory\Services\Item\ItemService;
use Modules\Inventory\Services\Stock\StockService;

abstract class TransactionService
{
    protected string $type;

    public function __construct(
        protected TransactionAccountingService $transactionAccounting
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

            // 2. MODEL CREATE / UPDATE
            $model = $id
                ? $this->update($id, $data, $totals)
                : $this->create($data, $totals);

            // 3. ITEM SAVE (ONLY DB LAYER)
            app(ItemService::class)->store(
                $model,
                $items,
                $this->relationKey()
            );

            // 4. STOCK ENGINE
            app(StockService::class)->process(
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

        $model = $class::findOrFail($id);

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

            // 🔥 1. STOCK REVERSE
            app(StockService::class)
                ->reverse($this->type, $model->id);

            $this->transactionAccounting->delete($model->id, $this->type);
            // 🔥 2. ACCOUNTING DELETE (HOOK)
            $this->afterDelete($model);

            // 🔥 3. DELETE ITEMS
            $model->items()->delete();

            // 🔥 4. DELETE MAIN MODEL
            $model->delete();
        });
    }

    protected function afterDelete($model): void
    {

    }
}