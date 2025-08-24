<?php

namespace Modules\Core\Http\Controllers\Api;

use Modules\Core\Http\Requests\ModuleRequest;

use Modules\Core\Models\Module;

class ModuleController extends BaseApiController
{
    protected string $title = 'Module';

    public function __construct()
    {
        $this->model = Module::class;
    }

     public function index()
    {
       return $this->indexData();
    }

   public function store(ModuleRequest $request)
    {
        $request->validated();
        return $this->saveData($request);  
    }

    public function show($id)
    {
        return $this->showData($id); 
    }

    public function update(ModuleRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id); 
    }

    public function destroy($id)
    {
        return $this->destroyData($id); 
    }
}
