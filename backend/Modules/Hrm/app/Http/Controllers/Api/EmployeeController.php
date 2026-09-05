<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\Employee;
use Modules\Hrm\Http\Requests\EmployeeRequest;
use Illuminate\Http\Request;

class EmployeeController extends BaseApiController
{
    protected string $title = 'Employee';

    public function __construct()
    {
        $this->model = Employee::class;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery();
        $query->with([
            'department',
            'designation',
            'gender',
            'religion',
            'shift',
            'employeeCategory',
            'employeeType',
            'employeeStatus',
            'bloodGroup'
        ]);
        
        return $this->listResponse($query->smartPaginate());

        // return $this->indexData($abc);
    }

    public function store(EmployeeRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(EmployeeRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
