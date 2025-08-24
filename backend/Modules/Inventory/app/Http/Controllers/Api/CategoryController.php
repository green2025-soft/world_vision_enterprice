<?php

namespace Modules\Inventory\Http\Controllers\Api;

use Illuminate\Http\Request;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Category;
use Modules\Inventory\Http\Requests\CategoryRequest;

class CategoryController extends BaseApiController
{
    protected string $title = 'Category';

    public function __construct()
    {
        $this->model = Category::class;
    }

    public function index(Request $request)
    {

         $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id']);

        return $this->listResponse($query->smartPaginate());
    }

    public function store(CategoryRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(CategoryRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
