<?php

namespace Modules\Hrm\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Hrm\Models\Gender;
use Modules\Hrm\Http\Requests\GenderRequest;
use Illuminate\Http\Request;

class GenderController extends BaseApiController
{
    protected string $title = 'Gender';

    public function __construct()
    {
        $this->model = Gender::class;
    }

    public function index(Request $request)
    {
        return $this->indexData();
    }

    public function store(GenderRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(GenderRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
