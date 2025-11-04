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
            $itemsData = $this->calculateItems($validated['items'], $validated);
            
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

   protected function calculateItems(array $items, $validated): array
    {
        $itemsData = [];

        foreach ($items as $item) {
            $quantity   = $item['quantity'];
            $unitPrice  = $item['unit_price'];
            $costPrice  = $item['cost_price'] ?? $unitPrice;

            // Subtotal (unit price × qty)
            $subtotal = $unitPrice * $quantity;

            // Discount handling
            $discountAmount = 0;
            $discountPercent = 0;

            if (!empty($item['discount_amount'])) {
                $discountAmount = floatval($item['discount_amount']);
                // Calculate percent from amount
                $discountPercent = $subtotal > 0 ? ($discountAmount / $subtotal) * 100 : 0;
            } elseif (!empty($item['discount_percent'])) {
                $discountPercent = floatval($item['discount_percent']);
                // Calculate amount from percent
                $discountAmount = ($discountPercent / 100) * $subtotal;
            }

            // Tax
            $taxable   = $subtotal - $discountAmount;
            $taxPercent = $item['tax_percent'] ?? 0;
            $taxAmount = ($taxPercent / 100) * $taxable;

            $total = $taxable + $taxAmount;

            // Inventory subtotal (based on cost price)
            $inventorySubtotal = $costPrice * $quantity;

            $itemsData[] = [
                'product_id'         => $item['product_id'],
                'quantity'           => $quantity,
                'unit_price'         => $unitPrice,
                'total_unit_price'   => $unitPrice * $quantity,
                'cost_price'         => $costPrice,
                'sale_price'         => $item['sale_price'] ?? null,

                // Sales account
                'net_price'          => $subtotal,
                'discount_percent'   => $discountPercent,
                'discount_amount'    => $discountAmount,
                'tax_percent'        => $taxPercent,
                'tax_amount'         => $taxAmount,
                'total_price'        => $total,

                // Inventory account
                'inventory_subtotal' => $inventorySubtotal,

                'invoice_date'       => $validated['invoice_date'],
                'branch_id'          => $validated['branch_id'],
                
            ];
        }

        return $itemsData;
    }





    protected function calculateTotals(array $itemsData, array $validated): array
    {
        // Inventory cost-based
        $inventoryAmount = array_sum(array_column($itemsData, 'inventory_subtotal'));

        // Sales price-based
        $salesAmount = array_sum(array_column($itemsData, 'net_price'));
        $itemDiscount = array_sum(array_column($itemsData, 'discount_amount'))??0;
        $itemDiscountPercent = array_sum(array_column($itemsData, 'discount_percent'))??0;
        // 🔁 Discount: amount > percent > none
        $discountAmount = 0;
        $discountPercent = 0;

        if (!empty($validated['discount_amount'])) {
            $discountAmount = floatval($validated['discount_amount']);
            $discountPercent = $salesAmount > 0 ? ($discountAmount / $salesAmount) * 100 : 0;
        } elseif (!empty($validated['discount_percent'])) {
            $discountPercent = floatval($validated['discount_percent']);
            $discountAmount = ($discountPercent / 100) * $salesAmount;
        }
        
        $discountAmount += $itemDiscount;
        $discountPercent += $itemDiscountPercent;

        // Tax calculation
        $taxPercent = 0;
        $taxAmount = 0;

        if (!empty($validated['tax_amount'])) {
            $taxAmount = floatval($validated['tax_amount']);
            $taxPercent = $salesAmount > 0 ? ($taxAmount / $salesAmount) * 100 : 0;
        } elseif (!empty($validated['tax_percent'])) {
            $taxPercent = floatval($validated['tax_percent']);
            $taxAmount = ($taxPercent / 100) * $salesAmount;
        }

        $itemTex        = array_sum(array_column($itemsData, 'discount_percent'))??0;
        $itemTexPercent = array_sum(array_column($itemsData, 'tax_percent'))??0;

         $taxPercent    +=  $itemTexPercent;
         $taxAmount     +=  $itemTex;

        // Adjustment
        $adjust = $validated['adjustment'] ?? 0;


        // Net Total
        $netTotal = ($salesAmount + $taxAmount) - ($discountAmount+$adjust);
        

        // Payments
        $paidAmount = $validated['paid_amount'] ?? 0;
        

        $advanceAdjusted = $validated['advance_adjusted'] ?? 0;
        $dueAmount = $netTotal - ($paidAmount + $advanceAdjusted);
        $dueAmount =   $dueAmount >0? $dueAmount :0;
        $totalUnitPrice = array_sum(array_column($itemsData, 'total_unit_price'));



        return [
            // Inventory
            'inventory'         => $inventoryAmount,

            'total_amount'      => $salesAmount,
            'discount_percent'  => $discountPercent,
            'discount_amount'   => $discountAmount,
            'tax_percent'       => $taxPercent,
            'tax_amount'        => $taxAmount,
            'adjustment'        => $adjust,
            'advance_adjusted'  => $advanceAdjusted,
            'net_total'         => $netTotal,
            'paid_amount'       => $paidAmount,
            'due_amount'        => $dueAmount,
            'total_discount'    => $discountAmount + $adjust,
            'total_unit_price'  => $totalUnitPrice
        ];
    }





    protected function createModel(array $validated, array $itemsData, array $totals)
    {
        $modelClass = $this->modelClass;
        $model = $modelClass::create(array_merge([
            'branch_id'  => $validated['branch_id'],
            'created_by' => auth()->id(),
        ], $validated, $totals));

        // foreach ($itemsData as &$item) {
        //     // $item[$this->getItemsForeignKey()] = $model->id;
        //     $item['branch_id'] = $validated['branch_id'];
        // }

        $model->items()->createMany($itemsData);
        // $this->getItemsModel()::insert($itemsData);

        return $model;
    }

    protected function updateModel(int $id, array $validated, array $itemsData, array $totals)
    {
        $modelClass = $this->modelClass;
        $model = $modelClass::findOrFail($id);

        app(StockMovementService::class)->validateEdit($this->movementType, $model, $validated['items']);

        $model->update(array_merge($validated, $totals));

        $model->items()->delete();

        // foreach ($itemsData as &$item) {
        //     // $item[$this->getItemsForeignKey()] = $model->id;
        //     $item['branch_id'] = $validated['branch_id'];
        // }
        $model->items()->createMany($itemsData);
        // $this->getItemsModel()::insert($itemsData);

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
        $model->branch_id,
        $this->movementType
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

        $this->afterDelete($model);
        // Delete the main record
        $model->delete();
    }

    protected function afterDelete($model): void
    {
        // To be implemented in child class, e.g., to delete accounting entries
    }
}
