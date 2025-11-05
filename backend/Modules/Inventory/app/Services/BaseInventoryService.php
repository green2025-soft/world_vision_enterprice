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

    private function percentAmountCal($price, $amount=0, $percent=0){
        if ($amount > 0) {
            // Calculate percent from amount
            $percent = $price > 0 ? ($amount / $price) * 100 : 0;
        } elseif ($percent > 0) {
            // Calculate amount from percent
            $amount = ($percent / 100) * $price;
        }
        return [
            'amount' => round($amount, 2),
            'percent' => round($percent, 2)
        ];
    
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
            $discountCall = $this->percentAmountCal( $subtotal, $item['discount_amount'], $item['discount_percent']);
            $discountAmount = $discountCall['amount'];
            $discountPercent = $discountCall['percent'];


            // Tax handling
            $taxable   = $subtotal - $discountAmount;

            $texCall = $this->percentAmountCal($subtotal, $item['tax_amount'], $item['tax_percent']);

            $taxPercent = $texCall['percent'];
            $taxAmount  = $texCall['amount'];

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
        $discountCall = $this->percentAmountCal( $salesAmount, $validated['discount_amount'], $validated['discount_percent']);
        $discountAmount = $discountCall['amount'];
        $discountPercent = $discountCall['percent'];

      
        $totalDiscountAmount  = $discountAmount;
        $totalDiscountPercent = $discountPercent;

        $totalDiscountAmount += $itemDiscount;
        $totalDiscountPercent += $itemDiscountPercent;

        // Tax calculation
        $taxableAmount = $salesAmount - $totalDiscountAmount;
        $textCall = $this->percentAmountCal(  $taxableAmount, $validated['tax_amount'], $validated['tax_percent']);
        $taxAmount  = $textCall['amount'];
        $taxPercent = $textCall['percent'];

        

        $itemTexAmount        = array_sum(array_column($itemsData, 'tax_amount'))??0;
        $itemTexPercent       = array_sum(array_column($itemsData, 'tax_percent'))??0;

        $totalTexAmount         = $taxAmount;
        $totalTexPercent        = $taxPercent;

         $totalTexPercent       +=  $itemTexPercent;
         $totalTexAmount        +=  $itemTexAmount;

        // Adjustment
        $adjust = $validated['adjustment'] ?? 0;


        // Net Total
        $netTotal = ($salesAmount + $totalTexAmount) - ($totalDiscountAmount+$adjust);
        

        // Payments
        $paidAmount = $validated['paid_amount'] ?? 0;
        

        $advanceAdjusted = $validated['advance_adjusted'] ?? 0;
        $dueAmount = $netTotal - ($paidAmount + $advanceAdjusted);
        $dueAmount =   $dueAmount >0? $dueAmount :0;
        $totalUnitPrice = array_sum(array_column($itemsData, 'total_unit_price'));

        return [
            // Inventory
            'inventory'                 => $inventoryAmount,
            'total_amount'              => $salesAmount,
            'discount_percent'          => $discountPercent,
            'discount_amount'           => $discountAmount,
            'total_discount_percent'    => $totalDiscountPercent,
            'total_discount_amount'     => $totalDiscountAmount,
            'adjustment'                => $adjust,
            'tax_percent'               => $taxPercent,
            'tax_amount'                => $taxAmount,
            'total_tax_percent'         => $totalTexPercent,
            'total_tax_amount'          => $totalTexAmount,
            'advance_adjusted'          => $advanceAdjusted,
            'net_total'                 => $netTotal,
            'paid_amount'               => $paidAmount,
            'due_amount'                => $dueAmount,
            'total_discount'            => $totalDiscountAmount + $adjust,
            'total_unit_price'          => $totalUnitPrice
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
