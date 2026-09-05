<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\EmployeeType;
use Modules\Hrm\Http\Requests\EmployeeTypeRequest;
use Illuminate\Http\Request;

class EmployeeTypeController extends BaseApiController
{
    protected string $title = 'EmployeeType';

    public function __construct()
    {
        $this->model = EmployeeType::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(EmployeeTypeRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(EmployeeTypeRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
