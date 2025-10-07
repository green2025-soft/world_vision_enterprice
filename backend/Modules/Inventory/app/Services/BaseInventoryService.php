<?php

namespace Modules\Inventory\Services;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\StockMovement;
use Modules\Inventory\Models\UserLog;

abstract class BaseInventoryService
{
    protected string $movementType;    // eg: 'purchase', 'sale', etc.
    protected string $modelClass;      // eg: Purchase::class, Sale::class, etc.

    public function __construct(string $movementType, string $modelClass)
    {
        $this->movementType = $movementType;
        $this->modelClass = $modelClass;
    }

    public function storeOrUpdate(array $validated, ?int $id = null)
    {
        return DB::transaction(function () use ($validated, $id) {
            $itemsData = $this->calculateItems($validated['items']);
            $totals = $this->calculateTotals($itemsData, $validated);

            $model = $id
                ? $this->updateModel($id, $validated, $itemsData, $totals)
                : $this->createModel($validated, $itemsData, $totals);

            $this->handleStock($model, $validated['items'], $id !== null);

          
            $this->afterStockHandling($model, $itemsData, $validated, $totals, $id !== null);

            $oldData = $model->toArray();

            $this->logActivity($id ? "{$this->movementType}_updated" : "{$this->movementType}_created", $model,$oldData );

            return $model;
        });
    }

    protected function calculateItems(array $items): array
    {
        $itemsData = [];
        foreach ($items as $item) {
            $subtotal = $item['unit_price'] * $item['quantity'];
            $discount = ($item['discount_percent'] ?? 0) * $subtotal / 100;
            $taxable = $subtotal - $discount;
            $tax = ($item['tax_percent'] ?? 0) * $taxable / 100;
            $total = $taxable + $tax;

            $itemsData[] = [
                'product_id'       => $item['product_id'],
                'quantity'         => $item['quantity'],
                'unit_price'       => $item['unit_price'],
                'sale_price'       => $item['sale_price'] ?? null,
                'discount_percent' => $item['discount_percent'] ?? 0,
                'tax_percent'      => $item['tax_percent'] ?? 0,
                'subtotal'         => $subtotal,
                'discount_amount'  => $discount,
                'tax_amount'       => $tax,
                'total'            => $total,
            ];
        }
        return $itemsData;
    }

    protected function calculateTotals(array $itemsData, array $validated): array
    {
        $totalAmount = array_sum(array_column($itemsData, 'total'));
        $discountPercent = $validated['discount_percent'] ?? 0;
        $discountAmount = ($discountPercent / 100) * $totalAmount;

        $taxPercent = $validated['tax_percent'] ?? 0;
        $taxAmount = ($taxPercent / 100) * ($totalAmount - $discountAmount);

        $adjust = $validated['adjustment'] ?? 0; 

        $netTotal = $totalAmount - $discountAmount + $taxAmount - $adjust;

        return [
            'total_amount'     => $totalAmount,
            'discount_percent' => $discountPercent,
            'discount_amount'  => $discountAmount,
            'tax_percent'      => $taxPercent,
            'tax_amount'       => $taxAmount,
            'adjustment'       => $adjust,
            'net_total'        => $netTotal,
            'paid_amount'      => $validated['paid_amount'] ?? 0,
            'due_amount'       => $netTotal - ($validated['paid_amount'] ?? 0),
        ];
    }

    protected function createModel(array $validated, array $itemsData, array $totals)
    {
        $modelClass = $this->modelClass;
        $model = $modelClass::create(array_merge([
            'branch_id'  => $validated['branch_id'],
            'created_by' => auth()->id(),
        ], $validated, $totals));

        foreach ($itemsData as &$item) {
            $item[$this->getItemsForeignKey()] = $model->id;
        }
        $this->getItemsModel()::insert($itemsData);

        return $model;
    }

    protected function updateModel(int $id, array $validated, array $itemsData, array $totals)
    {
        $modelClass = $this->modelClass;
        $model = $modelClass::findOrFail($id);

        app(StockMovementService::class)->validateEdit($this->movementType, $model, $validated['items']);

        $model->update(array_merge($validated, $totals));

        $model->items()->delete();

        foreach ($itemsData as &$item) {
            $item[$this->getItemsForeignKey()] = $model->id;
        }
        $this->getItemsModel()::insert($itemsData);

        return $model;
    }

    protected function handleStock($model, array $items, bool $isUpdate): void
    {
        if ($isUpdate) {
            StockMovement::where('movement_type', $this->movementType)
                ->where('reference_id', $model->id)
                ->delete();
        }

        app(StockMovementService::class)->handle($this->movementType, $model, $items);
    }

    protected function afterStockHandling($model, array $itemsData, array $validated, array $totals, bool $isUpdate)
    {
        
    }

protected function logActivity(string $action, $model, $oldData = null): void
{
    UserLog::record(
        $action,
        $model->toArray(),
        $model->id,
        $oldData ? json_encode($oldData) : null,
        $model->toArray(),
        $model->branch_id
    );
}


    protected function getItemsForeignKey(): string
    {
        // Override in child, eg: 'purchase_id', 'sale_id'
        return 'purchase_id';
    }

    protected function getItemsModel()
    {
        // Override in child, eg: PurchaseItem::class, SaleItem::class
        throw new \Exception('Must implement getItemsModel() in subclass');
    }

    public function delete(int $id): void
    {
        $modelClass = $this->modelClass;
        $model = $modelClass::findOrFail($id);

        // Validate delete permission or constraints
        app(StockMovementService::class)->validateDelete($this->movementType, $id);

        // Rollback stock balance from items — override this method if needed for different movement types
        app(StockBalanceService::class)->rollbackFromPurchase($model->items->toArray(), $model->branch_id);

        // Delete related items
        $model->items()->delete();

        // Delete stock movements
        StockMovement::where('movement_type', $this->movementType)
            ->where('reference_id', $id)
            ->delete();

        app(SupplierAccountingService::class)->deleteEntry($id, $this->movementType);
        // Delete the main record
        $model->delete();
    }
}
