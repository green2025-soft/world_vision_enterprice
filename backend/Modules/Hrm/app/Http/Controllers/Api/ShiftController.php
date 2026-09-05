<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\Shift;
use Modules\Hrm\Http\Requests\ShiftRequest;
use Illuminate\Http\Request;

class ShiftController extends BaseApiController
{
    protected string $title = 'Shift';

    public function __construct()
    {
        $this->model = Shift::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(ShiftRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(ShiftRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
