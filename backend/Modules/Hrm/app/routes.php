<?php

use Illuminate\Support\Facades\Route;


Route::apiResource('department', \Modules\Hrm\Controllers\Api\DepartmentController::class);
Route::apiResource('designation', \Modules\Hrm\Controllers\Api\DesignationController::class);
Route::apiResource('gender', \Modules\Hrm\Controllers\Api\GenderController::class);
Route::apiResource('religion', \Modules\Hrm\Controllers\Api\ReligionController::class);
Route::apiResource('shift', \Modules\Hrm\Controllers\Api\ShiftController::class);
Route::apiResource('employee-type', \Modules\Hrm\Controllers\Api\EmployeeTypeController::class);
Route::apiResource('employee-status', \Modules\Hrm\Controllers\Api\EmployeeStatusController::class);
Route::apiResource('blood-group', \Modules\Hrm\Controllers\Api\BloodGroupController::class);
Route::apiResource('employee-category', \Modules\Hrm\Controllers\Api\EmployeeCategoryController::class);
Route::apiResource('employee', \Modules\Hrm\Controllers\Api\EmployeeController::class);

Route::apiResource('leave-category', \Modules\Hrm\Controllers\Api\LeaveCategoryController::class);
Route::apiResource('leaves', \Modules\Hrm\Controllers\Api\LeaveController::class);