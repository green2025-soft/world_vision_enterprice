<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\Department;
use Modules\Hrm\Http\Requests\DepartmentRequest;
use Illuminate\Http\Request;

class DepartmentController extends BaseApiController
{
    protected string $title = 'Department';

    public function __construct()
    {
        $this->model = Department::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(DepartmentRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(DepartmentRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
