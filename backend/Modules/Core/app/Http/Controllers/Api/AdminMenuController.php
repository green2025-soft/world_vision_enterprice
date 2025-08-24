<?php

namespace Modules\Core\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Core\Models\AdminMenu;
use Modules\Core\Http\Requests\AdminMenuRequest;
use Illuminate\Http\Request;
class AdminMenuController extends BaseApiController
{
    protected string $title = 'Admin menu';

    public function __construct()
    {
        $this->model = AdminMenu::class;
    }

    public function index()
    {
        $menus = AdminMenu::whereNull('parent_id')
            ->orderBy('sequence', 'ASC')
            ->with('childrenRecursive', 'module:id,name')
            ->get();

        return $this->listItems($menus, "{$this->title} list fetched successfully.");
    }

    public function store(AdminMenuRequest $request)
    {
        $request->validated();
        $parentId = $request['parent_id'] ?? null;

        if ($parentId === null || $parentId === '' || $parentId === 0 || $parentId === '0') {
            $maxSequence = AdminMenu::whereNull('parent_id')->max('sequence');
        } else {
            $maxSequence = AdminMenu::where('parent_id', $parentId)->max('sequence');
        }

        $request['sequence'] = ($maxSequence === null) ? 1 : $maxSequence + 1;

        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(AdminMenuRequest $request, $id)
    {
        // dd($request);
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }

    public function parentMenus(){
       $parentMenus =  AdminMenu::whereNull('parent_id')
            ->ordered()
            ->get();

        return $this->listItems($parentMenus, "Admin parent menus list fetched successfully.");

    }

    public function reorder(Request $request)
    {
        $menus = $request->input('menus');

        $this->updateMenuOrder($menus);

       return $this->success(null, "{$this->title}  updated successfully.");

    }

    
    private function updateMenuOrder(array $menus, $parentId = null)
    {
        foreach ($menus as $index => $menu) {
            AdminMenu::where('id', $menu['id'])->update([
               'sequence' => $menu['sequence'],
                'parent_id' => $menu['parent_id']??null,
            ]);

            

            if (!empty($menu['children'])) {
                $this->updateMenuOrder($menu['children'], $menu['id']);
            }
        }
    }
}
