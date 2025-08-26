<?php

use Illuminate\Support\Facades\Route;
use Modules\Core\Http\Controllers\Api\AuthController;
use Modules\Core\Http\Controllers\Api\UserController;
use Modules\Core\Http\Controllers\Api\RoleController;
use Modules\Core\Http\Controllers\Api\ModuleController;
use Modules\Core\Http\Controllers\Api\SettingController;
use Modules\Core\Http\Controllers\Api\PermissionController;
use Modules\Core\Http\Controllers\Api\PermissionAssignController;
use Modules\Core\Http\Controllers\Api\AdminMenuController;
use Modules\Core\Http\Controllers\Api\BranchController;
use Modules\Core\Http\Controllers\Api\UserMenuController;

Route::prefix('v1/core')->group(function () {
    Route::controller(AuthController::class)->group(function () {
        Route::post('login', 'login');
        Route::middleware('auth:sanctum')->post('/logout', 'logout');
    });

    Route::get('settings', [SettingController::class, 'index'])->name('core.settings');

    Route::middleware(['auth:sanctum'])->name('core.')->group(function () {

        Route::get('user-menus', [UserMenuController::class, 'userMenus'])->name('user-menus');

        Route::middleware(['admin'])->group(function () {
            Route::post('settings/update', [SettingController::class, 'update'])->name('settings.update');
            Route::apiResource('users', UserController::class);
            Route::apiResource('roles', RoleController::class);
            Route::apiResource('modules', ModuleController::class);

            Route::get('admin-menus/parent', [AdminMenuController::class, 'parentMenus'])->name('admin-menus.parent');
            Route::post('admin-menus/reorder', [AdminMenuController::class, 'reorder'])->name('admin-menus.reorder');
            Route::apiResource('admin-menus', AdminMenuController::class);
            
            Route::prefix('permission')->name('permission.')->group(function () {
                Route::controller(PermissionController::class)->group(function () {
                    Route::get('sections', 'sections')->name('sections');
                    Route::post('permissions', 'permissions')->name('permissions');
                    Route::post('store', 'store')->name('store');
                });

                Route::controller(PermissionAssignController::class)->group(function () {
                    Route::post('assign', 'store')->name('assign');
                });

            });

            Route::get('branches/lists', [BranchController::class, 'branchList'])->name('.food-lists');
            Route::apiResource('branches', BranchController::class);

        });


        Route::get('/refresh-session', function () {
            auth()->user()->touch(); // session timestamp extend
            return response()->json(['message' => 'Session refreshed']);
        });
        
    });
    
});

