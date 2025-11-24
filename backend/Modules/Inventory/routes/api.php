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

Route::middleware(['auth:sanctum'])->prefix('v1/inventory')->name('inventory.')->group(function () {
// Route::middleware(['auth:sanctum', 'admin'])->prefix('v1/inventory')->name('inventory')->group(function () {
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('units', UnitController::class);
    Route::apiResource('brands', BrandController::class);
    Route::apiResource('products', ProductController::class);
    Route::get('products-overview/{id?}', [ProductController::class, 'getInventoryProducts'])->name('products-overview');
    Route::apiResource('product-sets', ProductSetController::class);
    Route::get('suppliers/balances/{id?}', [SupplierController::class, 'getSupplierBalances'])->name('suppliers.balances');
    Route::apiResource('suppliers', SupplierController::class);
 
    Route::apiResource('supplier-advance', SupplierAdvanceController::class);
    Route::get('supplier-advance/{id}/balance', [SupplierAdvanceController::class, 'supplierBalance']);
    Route::apiResource('customers', CustomerController::class);
     Route::apiResource('customer-advance', CustomerAdvanceController::class);
    Route::get('customer-advance/{id}/balance', [CustomerAdvanceController::class, 'customerBalance']);
    Route::apiResource('purchases', PurchaseController::class);
    Route::apiResource('sales', SaleController::class);

});
