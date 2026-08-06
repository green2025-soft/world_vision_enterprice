<?php

use Illuminate\Support\Facades\Route;
use Modules\Inventory\Http\Controllers\Api\BrandController;
use Modules\Inventory\Http\Controllers\Api\CategoryController;
use Modules\Inventory\Http\Controllers\Api\CustomerController;
use Modules\Inventory\Http\Controllers\Api\ProductController;
use Modules\Inventory\Http\Controllers\Api\ProductSetController;
use Modules\Inventory\Http\Controllers\Api\SupplierController;
use Modules\Inventory\Http\Controllers\Api\UnitController;
use Modules\Inventory\Http\Controllers\Api\SupplierAdvanceController;
use Modules\Inventory\Http\Controllers\Api\CustomerAdvanceController;
use Modules\Inventory\Http\Controllers\Api\PurchaseController;
use Modules\Inventory\Http\Controllers\Api\SaleController;
use Modules\Inventory\Http\Controllers\Api\SaleReturnController;
use Modules\Inventory\Http\Controllers\Api\PurchaseReturnController;
use Modules\Inventory\Http\Controllers\Api\CustomerPaymentController;
use Modules\Inventory\Http\Controllers\Api\SupplierPaymentController;
use Modules\Inventory\Http\Controllers\Api\StockTransferController;
use Modules\Inventory\Http\Controllers\Api\ProductWastageController;
use Modules\Inventory\Http\Controllers\Api\StockReports;

Route::middleware(['auth:sanctum'])->prefix('v1/inventory')->name('inventory.')->group(function () {
// Route::middleware(['auth:sanctum', 'admin'])->prefix('v1/inventory')->name('inventory')->group(function () {
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('units', UnitController::class);
    Route::apiResource('brands', BrandController::class);
    Route::apiResource('products', ProductController::class);
    Route::get('products-overview/{id?}', [ProductController::class, 'getInventoryProducts'])->name('products-overview');
    Route::apiResource('product-sets', ProductSetController::class);

    Route::get('suppliers/balances/{id?}', [SupplierController::class, 'getSupplierBalances'])->name('suppliers.balances');
    Route::get('suppliers/ledger', [SupplierController::class, 'ledger'])->name('suppliers.ledger');
    Route::apiResource('suppliers', SupplierController::class);
    Route::apiResource('supplier-advance', SupplierAdvanceController::class);
    Route::get('supplier-advance/{id}/balance', [SupplierAdvanceController::class, 'supplierBalance'])->name('supplier-advance.balances');


    Route::controller(CustomerController::class)->prefix('customers')->name('customers.')->group(function(){
        Route::get('balances/{id?}', 'getCustomerrBalances')->name('balances');
        Route::get('ledger', 'ledger')->name('ledger');
        Route::get('due-list', 'customerDueList')->name('due-list');
    });
    Route::apiResource('customers', CustomerController::class);
    Route::apiResource('customer-advance', CustomerAdvanceController::class);
    Route::get('customer-advance/{id}/balance', [CustomerAdvanceController::class, 'customerBalance'])->name('customer-advance.balances');

    Route::apiResource('purchases', PurchaseController::class);
    Route::apiResource('purchase-return', PurchaseReturnController::class);
    Route::get('purchase-invoice-items', [PurchaseController::class, 'invoiceItems'])->name('purchase-invoice-items');
    Route::get('sale-invoice-items', [SaleController::class, 'invoiceItems'])->name('sale-invoice-items');
    Route::apiResource('sales', SaleController::class);
    Route::apiResource('sale-return', SaleReturnController::class);
    Route::apiResource('customer-payment', CustomerPaymentController::class);
    Route::apiResource('supplier-payment', SupplierPaymentController::class);

    Route::apiResource('stock-transfers', StockTransferController::class);
    Route::apiResource('product-wastages', ProductWastageController::class);

    Route::prefix('reports')->name('reports.')->group(function () {
        Route::controller(StockReports::class)->group(function(){
            Route::get('product-stocks', 'index')->name('product-stocks');
            Route::get('product-stock-ledger', 'productStockLedger')->name('product-stock-ledger');
        });
    });

});
