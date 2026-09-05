<?php

use Illuminate\Support\Facades\Route;
use Modules\Hrm\Http\Controllers\HrmController;

Route::middleware(['auth', 'verified'])->group(function () {
    Route::resource('hrms', HrmController::class)->names('hrm');
});
