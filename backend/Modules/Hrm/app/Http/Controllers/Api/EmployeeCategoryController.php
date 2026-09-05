<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\EmployeeCategory;
use Modules\Hrm\Http\Requests\EmployeeCategoryRequest;
use Illuminate\Http\Request;

class EmployeeCategoryController extends BaseApiController
{
    protected string $title = 'EmployeeCategory';

    public function __construct()
    {
        $this->model = EmployeeCategory::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(EmployeeCategoryRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(EmployeeCategoryRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
