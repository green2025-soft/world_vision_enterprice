<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\Religion;
use Modules\Hrm\Http\Requests\ReligionRequest;
use Illuminate\Http\Request;

class ReligionController extends BaseApiController
{
    protected string $title = 'Religion';

    public function __construct()
    {
        $this->model = Religion::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(ReligionRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(ReligionRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
