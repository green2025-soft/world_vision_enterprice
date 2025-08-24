<?php

namespace Modules\Core\Http\Controllers\Api;

use Modules\Core\Http\Requests\UserRequest;
use Modules\Core\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Spatie\Permission\Models\Role;

class UserController extends BaseApiController
{
    public function index()
    {
        $users = User::with('roles')
            ->search()
            ->smartPaginate();

        return $this->paginated($users, 'User list fetched successfully.');
    }

    public function store(UserRequest $request)
    {
        $data = $request->validated();
        
        $user = User::create([
            'name'     => $data['name'],
            'email'    => $data['email'],
            'password' => Hash::make($data['password']),
        ]);

        $role = Role::findOrFail($data['role']); 
        // Assign role
        $user->assignRole($role);

        return $this->created($user->load('roles'), 'User created and role assigned successfully.');
    }

    public function show(User $user)
    {
        $user->load('roles');

        return $this->success($user, 'User fetched successfully.');
    }

    public function update(UserRequest $request, User $user)
    {
        $data = $request->validated();

        $user->update([
            'name'  => $data['name'],
            'email' => $data['email'],
        ]);

        if (isset($data['role_id'])) {
            $user->syncRoles([$data['role_id']]);
        }

        return $this->success($user->load('roles'), 'User updated successfully.');
    }

    public function destroy(User $user)
    {
        if ($user->id === Auth::id()) {
            return $this->forbidden('You cannot delete your own account.');
        }

        $user->syncRoles([]); // detach all roles
        $user->delete();

        return $this->success(null, 'User deleted successfully.');
    }
}
