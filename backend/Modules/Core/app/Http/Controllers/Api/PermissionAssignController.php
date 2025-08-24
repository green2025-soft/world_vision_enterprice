<?php

namespace Modules\Core\Http\Controllers\Api;

use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Modules\Core\Http\Requests\AssignPermissionRequest;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;

class PermissionAssignController extends BaseApiController
{
	
  public function store(AssignPermissionRequest $request): JsonResponse
{
    $data = $request->validated();

    $role = Role::findOrFail($data['role_id']);

    DB::transaction(function () use ($role, $data) {
        // Load permission models from IDs before syncing
        $permissions = Permission::whereIn('id', $data['permissions'])->get();
        $role->syncPermissions($permissions);
    });

    return $this->created([
        'role' => $role->name,
        'permissions' => Permission::whereIn('id', $data['permissions'])->get(['id', 'name']),
    ], 'Permissions assigned successfully.');
}

}
