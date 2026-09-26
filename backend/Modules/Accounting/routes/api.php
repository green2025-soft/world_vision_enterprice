<?php

use Illuminate\Support\Facades\Route;
use Modules\Accounting\Http\Controllers\Api\ChartOfAccountController;
use Modules\Accounting\Http\Controllers\Api\AccountModuleController;
use Modules\Accounting\Http\Controllers\Api\JournalEntryController;
use Modules\Accounting\Http\Controllers\Api\AccountsReportController;
use Modules\Accounting\Http\Controllers\Api\TrialBalanceController;

Route::middleware(['auth:sanctum'])->prefix('v1/accounting')->name('accounting.')->group(function () {
    // Route::middleware(['auth:sanctum', 'admin'])->prefix('v1/accounting')->name('accounting.')->group(function () {

    Route::apiResource('chart-of-accounts', ChartOfAccountController::class);
    Route::get('trial-balance', [TrialBalanceController::class, 'index'])->name('trial-balance');
    Route::get('cash-flow-statement', [\Modules\Accounting\Http\Controllers\Api\CashFlowStatementController::class, 'index'])->name('cash-flow-statement');
    Route::get('cash-bank-book', [\Modules\Accounting\Http\Controllers\Api\CashBankBookController::class, 'index'])->name('cash-bank-book');
    Route::get('changes-in-equity', [\Modules\Accounting\Http\Controllers\Api\ChangesInEquityController::class, 'index'])->name('changes-in-equity');
    Route::get('ledger-report/accounts', [\Modules\Accounting\Http\Controllers\Api\LedgerReportController::class, 'accounts'])->name('ledger-report.accounts');
    Route::get('ledger-report', [\Modules\Accounting\Http\Controllers\Api\LedgerReportController::class, 'index'])->name('ledger-report');
    Route::get('receipts-payments', [\Modules\Accounting\Http\Controllers\Api\ReceiptsPaymentsController::class, 'index'])->name('receipts-payments');

    Route::controller(ChartOfAccountController::class)->group(function(){
        Route::get('account-heads/{id?}','accountHeads')->name('account-heads');
        Route::get('transaction-accounts','transactionAccounts')->name('transaction-accounts');

        Route::get('voucher-types','voucherTypes')->name('voucher-types');
    });

    Route::get('generate-reference-no', [JournalEntryController::class,'generateReferenceNo'])->name('generate-reference-no');
    
    Route::apiResource('journal-entries', JournalEntryController::class);
    Route::get('account-modules/available', [AccountModuleController::class, 'getAvailableModules'])->name('account-modules.available');
    Route::apiResource('account-modules', AccountModuleController::class);

    Route::controller(AccountsReportController::class)->group(function(){
        Route::get('balance-sheet','balanceSheet')->name('balance-sheet');
        Route::get('income-expenditure','incomeExpenditure')->name('income-expenditure');
    });

});
