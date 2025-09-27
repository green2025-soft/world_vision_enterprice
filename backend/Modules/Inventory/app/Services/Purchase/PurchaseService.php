<?php 

namespace Modules\Inventory\Services\Purchase;

use Illuminate\Support\Facades\DB;
use Modules\Inventory\Models\Purchase;
use Modules\Inventory\Models\PurchaseItem;

use Modules\Inventory\Services\SupplierAccountingService;
use Modules\Inventory\Services\Purchase\StockMovementService;
use Modules\Inventory\Services\StockBalanceService;
use Modules\Inventory\Services\PriceListService;
use Modules\Inventory\Models\UserLog;

class PurchaseService
{
    public function store(array $validated): Purchase
    {
        return DB::transaction(function () use ($validated) {

            $itemsData = [];
            $totalAmount = 0;

            // 1️⃣ Loop through items and calculate total
            foreach ($validated['items'] as $item) {
                $subtotal = $item['unit_price'] * $item['quantity'];
                $discountAmount = ($item['discount_percent'] ?? 0) * $subtotal / 100;
                $taxableAmount = $subtotal - $discountAmount;
                $taxAmount = ($item['tax_percent'] ?? 0) * $taxableAmount / 100;
                $total = $taxableAmount + $taxAmount;

                $itemsData[] = [
                    'product_id'       => $item['product_id'],
                    'quantity'         => $item['quantity'],
                    'unit_price'       => $item['unit_price'],
                    'sale_price'       => $item['sale_price'] ?? null,
                    'discount_percent' => $item['discount_percent'] ?? 0,
                    'tax_percent'      => $item['tax_percent'] ?? 0,
                    'subtotal'         => $subtotal,
                    'discount_amount'  => $discountAmount,
                    'tax_amount'       => $taxAmount,
                    'total'            => $total,
                ];

                $totalAmount += $total;
            }

            // 2️⃣ Header-level Calculations
            $discountPercent = $validated['discount_percent'] ?? 0;
            $discountAmount = ($discountPercent / 100) * $totalAmount;

            $taxPercent = $validated['tax_percent'] ?? 0;
            $taxAmount = ($taxPercent / 100) * ($totalAmount - $discountAmount);

            $supplierAdjust = $validated['supplier_adjust'] ?? 0;

            $netTotal = $totalAmount - $discountAmount + $taxAmount - $supplierAdjust;
            $paidAmount = $validated['paid_amount'] ?? 0;
            $dueAmount = $netTotal - $paidAmount;

            // 3️⃣ Create Purchase
            $purchase = Purchase::create([
                'supplier_id'       => $validated['supplier_id'],
                'invoice_no'        => $validated['invoice_no'] ?? null,
                'invoice_date'      => $validated['invoice_date'],
                'total_amount'      => $totalAmount,
                'discount_percent'  => $discountPercent,
                'discount_amount'   => $discountAmount,
                'tax_percent'       => $taxPercent,
                'tax_amount'        => $taxAmount,
                'supplier_adjust'   => $supplierAdjust,
                'net_total'         => $netTotal,
                'paid_amount'       => $paidAmount,
                'due_amount'        => $dueAmount,
                'remarks'           => $validated['remarks'] ?? null,
                'branch_id'         => $validated['branch_id'],
                'created_by'        => auth()->id(),
            ]);

            // 4️⃣ Insert Items
            foreach ($itemsData as &$item) {
                $item['purchase_id'] = $purchase->id;
            }
            PurchaseItem::insert($itemsData);

            // 5️⃣ Stock Movement
            app(StockMovementService::class)->handle($purchase, $itemsData);

            // 6️⃣ Stock Balance
            app(StockBalanceService::class)->updateFromPurchase($itemsData, $validated['branch_id']);

            // 7️⃣ Price List
            app(PriceListService::class)->updatePrices($itemsData);

            // 8️⃣ Supplier Accounting

            $supplierAccounting = app(SupplierAccountingService::class, [
                'moduleName' => 'Purchase',
                'sourceType' => 'purchase'
            ]);

            if ($supplierAdjust > 0) {
                $supplierAccounting->recordTransaction([
                    'supplier_id'   => $purchase->supplier_id,
                    'amount'        => $supplierAdjust,
                    'date'          => $purchase->invoice_date,
                    'reference_id'  => $purchase->id,
                    'reference_no'  => $purchase->invoice_no,
                    'branch_id'     => $purchase->branch_id,
                    'note'          => 'Supplier Advance Adjustment',
                ], 'adjustment');
            }

            $supplierAccounting->recordTransaction([
                'supplier_id'   => $purchase->supplier_id,
                'amount'        => $netTotal,
                'date'          => $purchase->invoice_date,
                'reference_id'  => $purchase->id,
                'reference_no'  => $purchase->invoice_no,
                'branch_id'     => $purchase->branch_id,
                'note'          => 'Purchase Invoice',
            ], 'purchase');

            // 9️⃣ User Log
            UserLog::record('purchase_created', $purchase->toArray(), $purchase->id, null, $purchase->toArray(), $purchase->branch_id);

            return $purchase;
        });
    }

}
