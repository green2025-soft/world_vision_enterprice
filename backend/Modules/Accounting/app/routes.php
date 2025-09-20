<?php

use Illuminate\Support\Facades\Route;


Route::apiResource('account-head', \Modules\Accounting\Controllers\Api\AccountHeadController::class);
Route::apiResource('journal-entry', \Modules\Accounting\Controllers\Api\JournalEntryController::class);
Route::apiResource('account-module', \Modules\Accounting\Controllers\Api\AccountModuleController::class);