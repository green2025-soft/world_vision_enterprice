<?php

use Illuminate\Support\Facades\Route;


Route::apiResource('branch', \Modules\Core\Controllers\Api\BranchController::class);