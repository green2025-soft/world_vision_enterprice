<?php

namespace Modules\Core\Http\Controllers;
use Illuminate\Routing\Controller;

use Modules\Core\Models\Module;
use Modules\Core\Models\PermissionGroup;

use Illuminate\Support\Facades\Route;
use Spatie\Permission\Models\Permission;

use Spatie\Permission\Models\Role;

class NewAllRoutePermissionController extends Controller
{


    public function __construct(){
    
        
    }

    public function store()
    {
        $roleId = 1; // default role (e.g., Super Admin)
        $modules = $this->getModuleSlugIdMap();
        $routes = $this->getFilteredRoutes();

        $permissionIds = [];
        $totalRoutes = 0;

        foreach ($routes as $route) {
            $routeName = $route->getName();
            $moduleSlug = $this->getRoutePart($routeName, 1); // e.g., 'roles' from 'api.core.roles.index'

            if (!$moduleSlug || !isset($modules[$moduleSlug])) {
                continue;
            }

            $moduleId = $modules[$moduleSlug];
            $sectionName = $this->getRoutePart($routeName, 2);
            $totalRoutes++;

            // Create or get PermissionGroup
            $permissionGroup = PermissionGroup::updateOrCreate(
                ['name' => $sectionName, 'module_id' => $moduleId],
                ['name' => $sectionName, 'module_id' => $moduleId]
            );

            // Create or update Permission
            $permission = Permission::updateOrCreate(
                ['name' => $routeName],
                [
                    'name'         => $routeName,
                    'group_id'     => $permissionGroup->id,
                    'module_id'    => $moduleId,
                    'display_name' => $this->generateDisplayName($routeName),
                    'guard_name'   => 'sanctum'
                ]
            );

            $permissionIds[] = $permission->id;
        }

        // Assign all permissions to the given role
        $this->assignPermissionsToRole($roleId, $permissionIds);

        dd('Total Route '.$totalRoutes.' Permission generation successful');

    }

    /**
     * Get only API named routes excluding system/debug routes.
     */
    private function getFilteredRoutes()
    {
        return collect(Route::getRoutes())->filter(function ($route) {
            $name = $route->getName();
            $middleware = $route->action['middleware'][1] ?? '';

            return $name
                && !str_starts_with($name, 'debugbar')
                && !str_starts_with($name, 'ignition')
                && !str_starts_with($name, 'sanctum')
                && $middleware;
        });
    }

    /**
     * Convert route name like 'api.core.users.index' → 'Api Core Users Index'
     */
    private function generateDisplayName($routeName)
    {
        return ucwords(str_replace(['.', '_'], ' ', $routeName));
    }

    private function getModuleSlugIdMap()
    {
        return Module::pluck('id', 'slug')->toArray(); // [slug => id]
    }


       private function getRoutePart($routeName, $index)
    {
        $parts = explode('.', $routeName);
        return $parts[$index] ?? null;
    }

     private function assignPermissionsToRole($roleId, array $permissionIds)
    {
        $role = Role::find($roleId);

        if ($role && !empty($permissionIds)) {
            $role->syncPermissions($permissionIds); 
        }
    }

    public function getAllRoutes(){
        $name = collect(Route::getRoutes())->filter(function ($route) {
            $middleware = $route->action['middleware'][1]??'';
            return $middleware && $route->getName() !=='api.'? $route->getName():''; // only named routes
        });
        $sl =0;
        foreach ($name as $value) {
            $rul = $value->uri();
            $routeName = $value->getName();
            $route_names= explode('.',$routeName);
            if (!empty($routeName) && $route_names[0] !='debugbar' && $route_names[0] !='ignition' && $route_names[0] !='sanctum') {
                $sl++;
                $routeName = $value->getName();
                echo '<p style="margin: 10px 40px; font-size: 25px">('.$sl.') '.$rul. ' <spen style="background: #cccccc7a;padding: 0px 6px;
    border-radius: 5px; color: #2e2c2c;">(' .$routeName.')</spen></p>';
            }

        }
        dd('Total Route '.$sl.' ');
    }


}
