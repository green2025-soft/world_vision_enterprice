<?php

use Illuminate\Support\Facades\Route;


Route::apiResource('unit', \Modules\Inventory\Controllers\Api\UnitController::class);
Route::apiResource('product', \Modules\Inventory\Controllers\Api\ProductController::class);
Route::apiResource('brand', \Modules\Inventory\Controllers\Api\BrandController::class);
Route::apiResource('product', \Modules\Inventory\Controllers\Api\ProductController::class);
Route::apiResource('supplier', \Modules\Inventory\Controllers\Api\SupplierController::class);
Route::apiResource('customer', \Modules\Inventory\Controllers\Api\CustomerController::class);