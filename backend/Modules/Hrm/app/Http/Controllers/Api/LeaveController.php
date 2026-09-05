<?php

namespace Modules\Hrm\Http\Controllers\Api;

use Modules\Core\Http\Controllers\Api\BaseApiController;
use Modules\Hrm\Models\Leave;
use Modules\Hrm\Http\Requests\LeaveRequest;
use Illuminate\Http\Request;

class LeaveController extends BaseApiController
{
    protected string $title = 'Leave';

    public function __construct()
    {
        // Keep this as a clean class string reference
        $this->model = Leave::class;
    }

    public function index(Request $request)
    {
        // Handled automatically by protected $with in Leave model
        return $this->indexData();
    }

    public function show($id)
    {
        // Handled automatically by protected $with in Leave model
        return $this->showData($id);
    }

    public function store(LeaveRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function update(LeaveRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
