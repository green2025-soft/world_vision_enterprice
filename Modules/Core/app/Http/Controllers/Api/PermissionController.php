<?php

namespace Modules\Core\Http\Controllers\Api;

use Modules\Core\Http\Requests\PermissionRequest;
use Modules\Core\Models\PermissionGroup;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use DB;
use Illuminate\Http\Request;
use Modules\Core\Models\Module;

class PermissionController extends BaseApiController
{

    public function sections(Request $request){
        $moduleId  = $request['module_id'];
        $query      = PermissionGroup::select('name','module_id');
        if ($moduleId){
            $query->where('module_id', $moduleId);
        }
        return $this->success( $query->get());  
    }

    public function permissions(Request $request)
    {
        
        //  Validate required input
        $request->validate([
            'role_id' => 'required',
        ]);
            
       
        // Extract input values
        $roleId     = $request->input('role_id');
        $moduleId   = $request->input('module_id');
        $sectionId  = $request->input('section_id');

        // Build the query with status check and eager loading
        $modulesQuery = Module::query()
            ->where('status', 1)
            ->orderBy('name')
            ->with(['permissionGroups' => function ($query) use ($moduleId, $sectionId) {
                // Apply filters if present
                if ($moduleId) {
                    $query->where('module_id', $moduleId);
                }
                if ($sectionId) {
                    $query->where('id', $sectionId);
                }

                // Also load permissions inside permission groups
                $query->with('permissions');
            }]);

        // Apply condition to only return modules that have matching permissionGroups
        $modulesQuery->whereHas('permissionGroups', function ($query) use ($moduleId, $sectionId) {
            if ($moduleId) {
                $query->where('module_id', $moduleId);
            }
            if ($sectionId) {
                $query->where('id', $sectionId);
            }
        });

        // Execute the query and get results
        $modulesPermissions = $modulesQuery->get();

        $assignedPermissions = Role::find($roleId)?->permissions->pluck('id')->toArray() ?? [];

        $modulesPermissions->each(function ($module) use ($assignedPermissions) {
        $module->permissionGroups->each(function ($group) use ($assignedPermissions) {
        $group->permissions->each(function ($permission) use ($assignedPermissions) {
            $permission->is_checked = in_array($permission->id, $assignedPermissions);
        });
    });
});

        //  Return success response
        return $this->success($modulesPermissions);
    }




    public function store(PermissionRequest $request)
    {
        $data = $request->validated();

        $permission = DB::transaction(function () use ($data) {
            $group = PermissionGroup::updateOrCreate(
                ['name' => $data['section_name'], 'module_id' => $data['module_name']],
                ['name' => $data['section_name'], 'module_id' => $data['module_name']]
            );

            $permission = Permission::firstOrCreate([
                'name'      => $data['route_name'],
                'group_id'  => $group->id,
                'module_id' => $data['module_name'],
            ]);

          foreach ($data['role'] as $roleId) {
                if ($role = Role::find($roleId)) {
                    $role->permissions()->attach($permission->id);
                }
            }

            return $permission;
        });

        return $this->created($permission, 'Permission created and assigned successfully.');
    }


}
