<?php

namespace Modules\Core\Http\Middleware;
use Illuminate\Support\Facades\Route;
use Closure;
use Illuminate\Http\Request;

class AdminMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {

        $user = $request->user();
        $permission = $request->route()->getName();
         if (!$permission) {
            return $next($request);
        }
		
        if (!$user || !$user->can($permission)) {
            return response()->json([
                'message' => 'Forbidden - You do not have permission to access this route.',
            ], 403);
        }

        return $next($request);


    }
}
