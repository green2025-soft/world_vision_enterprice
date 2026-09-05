<?php

use Illuminate\Support\Facades\Route;
use Modules\Hrm\Http\Controllers\Api\DepartmentController;
use Modules\Hrm\Http\Controllers\Api\DesignationController;
use Modules\Hrm\Http\Controllers\Api\GenderController;
use Modules\Hrm\Http\Controllers\Api\ReligionController;
use Modules\Hrm\Http\Controllers\Api\ShiftController;
use Modules\Hrm\Http\Controllers\Api\EmployeeCategoryController;
use Modules\Hrm\Http\Controllers\Api\EmployeeTypeController;
use Modules\Hrm\Http\Controllers\Api\EmployeeStatusController;
use Modules\Hrm\Http\Controllers\Api\BloodGroupController;
use Modules\Hrm\Http\Controllers\Api\EmployeeController;
use Modules\Hrm\Http\Controllers\Api\LeaveCategoryController;
use Modules\Hrm\Http\Controllers\Api\LeaveController;

Route::middleware(['auth:sanctum'])->prefix('v1/hrm')->name('hrm.')->group(function () {
// Route::middleware(['auth:sanctum', 'admin'])->prefix('v1/hrm')->name('hrm.')->group(function () {
    Route::apiResource('departments', DepartmentController::class);
    Route::apiResource('designations', DesignationController::class);
    Route::apiResource('genders', GenderController::class);
    Route::apiResource('religions', ReligionController::class);
    Route::apiResource('shifts', ShiftController::class);
    Route::apiResource('employee-categories', EmployeeCategoryController::class);
    Route::apiResource('employee-types', EmployeeTypeController::class);
    Route::apiResource('employee-status', EmployeeStatusController::class);
    Route::apiResource('blood-group', BloodGroupController::class);
    Route::apiResource('employees', EmployeeController::class);
    Route::apiResource('leave-categories', LeaveCategoryController::class);
    Route::apiResource('leaves', LeaveController::class);
});

