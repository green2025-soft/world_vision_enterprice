<?php

namespace Modules\Core\Http\Controllers\Api;

use Illuminate\Support\Facades\Log;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Core\Models\Branch;
use Modules\Core\Http\Requests\BranchRequest;

class BranchController extends BaseApiController
{
    protected string $title = 'Branch';

    public function __construct()
    {
        $this->model = Branch::class;
    }

    public function index()
    {
        return $this->indexData();
    }

    public function store(BranchRequest $request)
    {
        $request->validated();
         if ($request->hasFile('fileLogo')) {
            $imageUrl = uploadImage($request->file('fileLogo'), 'core/branch');
            $request['logo'] = $imageUrl;
        }
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(BranchRequest $request, $id)
    {
        $request->validated();
    
        if ($request->hasFile('fileLogo')) {
             $data = $this->model::findOrFail($id);
             $imageUrl = uploadImage($request->file('fileLogo'), 'core/branch', $data->logo);
             $request['logo'] = $imageUrl;
        }
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }

    public function branchList()
    {
        return $this->allItems();
    }
}
