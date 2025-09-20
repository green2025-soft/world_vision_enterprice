<?php

use Illuminate\Support\Facades\Route;
use Modules\Accounting\Http\Controllers\Api\ChartOfAccountController;
use Modules\Accounting\Http\Controllers\Api\AccountModuleController;
use Modules\Accounting\Http\Controllers\Api\JournalEntryController;

Route::middleware(['auth:sanctum'])->prefix('v1/accounting')->name('accounting.')->group(function () {
    // Route::middleware(['auth:sanctum', 'admin'])->prefix('v1/accounting')->name('accounting.')->group(function () {

    Route::apiResource('chart-of-accounts', ChartOfAccountController::class);

    Route::controller(ChartOfAccountController::class)->group(function(){
        Route::get('account-heads','accountHeads')->name('account-heads');
        Route::get('voucher-types','voucherTypes')->name('voucher-types');
    });

    Route::get('generate-reference-no', [JournalEntryController::class,'generateReferenceNo'])->name('generate-reference-no');
    
    Route::apiResource('journal-entries', JournalEntryController::class);
    Route::apiResource('account-modules', AccountModuleController::class);

});

