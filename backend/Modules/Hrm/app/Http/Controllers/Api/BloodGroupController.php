<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\BloodGroup;
use Modules\Hrm\Http\Requests\BloodGroupRequest;
use Illuminate\Http\Request;

class BloodGroupController extends BaseApiController
{
    protected string $title = 'BloodGroup';

    public function __construct()
    {
        $this->model = BloodGroup::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(BloodGroupRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(BloodGroupRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
