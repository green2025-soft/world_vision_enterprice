<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class AdminPermission
{
    /**
     * Handle an incoming request.
     *
     * Check if the authenticated user has required permission(s)
     * The permission(s) should be passed via route middleware parameter
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string  $permission  // permission name(s), can be pipe-separated
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function handle(Request $request, Closure $next, string $permission): Response
    {
        $user = $request->user();

        if (!$user) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        // Allow multiple permissions separated by |
        $permissions = explode('|', $permission);

        // Check if user has any of the permissions
        if (!$user->hasAnyPermission($permissions)) {
            return response()->json(['message' => 'Forbidden: insufficient permission'], 403);
        }

        return $next($request);
    }
}