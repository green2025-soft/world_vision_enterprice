<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\Designation;
use Modules\Hrm\Http\Requests\DesignationRequest;
use Illuminate\Http\Request;

class DesignationController extends BaseApiController
{
    protected string $title = 'Designation';

    public function __construct()
    {
        $this->model = Designation::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(DesignationRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(DesignationRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
