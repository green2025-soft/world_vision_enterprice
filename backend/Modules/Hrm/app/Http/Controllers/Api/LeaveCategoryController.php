<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\LeaveCategory;
use Modules\Hrm\Http\Requests\LeaveCategoryRequest;
use Illuminate\Http\Request;

class LeaveCategoryController extends BaseApiController
{
    protected string $title = 'LeaveCategory';

    public function __construct()
    {
        $this->model = LeaveCategory::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(LeaveCategoryRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(LeaveCategoryRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
