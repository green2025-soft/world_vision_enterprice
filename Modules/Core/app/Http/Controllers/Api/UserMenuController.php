<?php

namespace Modules\Core\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Core\Models\AdminMenu;
use Auth;
use Modules\Core\Models\Module;

class UserMenuController extends BaseApiController
{
    protected string $title = 'User menu';
    

    public function __construct()
    {
        $this->model = AdminMenu::class;
    }


    public function userMenus()
    {
        $user = Auth::user();
        $permissions = $user->getAllPermissions()->pluck('name')->toArray();

        $menus = AdminMenu::where('status', 1)
            ->orderBy('sequence')
            ->get();

        $allowedMenus = $menus->filter(function ($menu) use ($permissions) {
            return !$menu->permission_route || in_array($menu->permission_route, $permissions);
        });

        $parentIds = $allowedMenus->pluck('parent_id')->filter()->unique();
        $parentMenus = $menus->whereIn('id', $parentIds);

        $finalMenus = $allowedMenus->merge($parentMenus)->unique('id');
        $grouped = $finalMenus->groupBy('module_id');

        // ✅ Optimized module fetching (no N+1)
        $modules = Module::whereIn('id', $grouped->keys())->get()->keyBy('id');

        $menuByModule = $grouped->map(function ($menus, $moduleId) use ($modules) {
            $module = $modules[$moduleId] ?? null;

            return [
                'module_id' => $moduleId,
                'module_name' => $module->name ?? 'Unknown',
                'module_slug' => $module->slug ?? 'unknown',
                'menus' => $this->buildMenuTree($menus, null)
            ];
        })->values();

        return $this->success($menuByModule);
    }



private function buildMenuTree($menus, $parentId = null)
{
    return $menus->filter(function ($menu) use ($parentId) {
        return $menu->parent_id == $parentId;
    })->map(function ($menu) use ($menus) {
        return [
            'id' => $menu->id,
            'title' => $menu->title,
            'icon' => $menu->icon,
            'route' => $menu->route,
            'children' => $this->buildMenuTree($menus, $menu->id)
        ];
    })->values();
}

}
