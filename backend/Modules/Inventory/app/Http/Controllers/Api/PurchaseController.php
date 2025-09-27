<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Purchase;
use Modules\Inventory\Http\Requests\PurchaseRequest;
use Illuminate\Http\Request;

class PurchaseController extends BaseApiController
{
    protected string $title = 'Purchase';

    public function __construct()
    {
        $this->model = Purchase::class;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id']);

        return $this->listResponse($query->smartPaginate());
    }

    public function store(PurchaseRequest $request)
    {
        $request->validated();
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(PurchaseRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
