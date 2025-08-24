<?php

use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function () {



  Route::get('all/clear', function () {
        if (!app()->isLocal()) {
            abort(403, 'Unauthorized');
        }

        Artisan::call('config:clear');
        Artisan::call('route:clear');
        Artisan::call('view:clear');
        Artisan::call('event:clear');
        Artisan::call('cache:clear');
        
        Artisan::call('config:cache');
        Artisan::call('event:cache');
        Artisan::call('route:cache');
        Artisan::call('view:cache');

        return response()->json(['message' => 'All cache cleared and re-cached successfully']);
    });
});

