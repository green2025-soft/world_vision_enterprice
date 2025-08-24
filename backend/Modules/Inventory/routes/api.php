<?php

use Illuminate\Support\Facades\Route;
use Modules\Inventory\Http\Controllers\Api\BrandController;
use Modules\Inventory\Http\Controllers\Api\CategoryController;
use Modules\Inventory\Http\Controllers\Api\CustomerController;
use Modules\Inventory\Http\Controllers\Api\ProductController;
use Modules\Inventory\Http\Controllers\Api\SupplierController;
use Modules\Inventory\Http\Controllers\Api\UnitController;

Route::middleware(['auth:sanctum'])->prefix('v1/inventory')->name('inventory')->group(function () {
// Route::middleware(['auth:sanctum', 'admin'])->prefix('v1/inventory')->name('inventory')->group(function () {
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('units', UnitController::class);
    Route::apiResource('brands', BrandController::class);
    Route::apiResource('products', ProductController::class);
    Route::apiResource('suppliers', SupplierController::class);
    Route::apiResource('customers', CustomerController::class);

});
