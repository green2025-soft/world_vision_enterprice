<?php

namespace Modules\Core\Http\Controllers\Api;

use Auth;
use Modules\Core\Http\Requests\AuthRequest;
use Illuminate\Http\Request;

class AuthController extends BaseApiController
{

    public function login(AuthRequest $request)
    {
        $credentials = $request->validated();
        
         if (!Auth::attempt($credentials)) {
               return $this->validationError([
                    'email' => ['Invalid credentials provided.'],
                ], 'Login failed');
         }

        $user = Auth::user();
        $token = $user->createToken('api-token')->plainTextToken;

        return $this->success([
            'user' => $user,
            'token' => $token,
        ], 'Successfully login');
        
    }

    public function logout(Request $request)
    {
    $user = $request->user(); // Get the authenticated user

    // Revoke the token that was used to authenticate the current request
    $user->currentAccessToken()->delete();

    return $this->success([], 'Successfully logged out');
    }
}
