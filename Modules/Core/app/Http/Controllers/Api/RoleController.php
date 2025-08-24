<?php

namespace Modules\Core\Http\Controllers\Api;

use Spatie\Permission\Models\Role;
use Modules\Core\Http\Requests\RoleRequest;

class RoleController extends BaseApiController
{
    protected string $title = 'Role';

    public function __construct()
    {
        $this->model = Role::class;
    }

     public function index()
    {
        $roleData = ($this->model)::orderBy('direction')->get();
         return $this->success($roleData);  
    }
   public function store(RoleRequest $request)
    {
        $request->validated();
        return $this->saveData($request);  
    }

    public function show($id)
    {
        return $this->showData($id); 
    }

    public function update(RoleRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id); 
    }

    public function destroy($id)
    {
        return $this->destroyData($id); 
    }
}
