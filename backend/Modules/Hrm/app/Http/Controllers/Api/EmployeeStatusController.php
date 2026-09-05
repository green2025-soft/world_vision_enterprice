<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\EmployeeStatus;
use Modules\Hrm\Http\Requests\EmployeeStatusRequest;
use Illuminate\Http\Request;

class EmployeeStatusController extends BaseApiController
{
    protected string $title = 'EmployeeStatus';

    public function __construct()
    {
        $this->model = EmployeeStatus::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(EmployeeStatusRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(EmployeeStatusRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
