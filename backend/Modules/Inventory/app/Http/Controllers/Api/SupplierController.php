<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Supplier;
use Modules\Inventory\Http\Requests\SupplierRequest;
use Illuminate\Http\Request;

class SupplierController extends BaseApiController
{
    protected string $title = 'Supplier';

    public function __construct()
    {
        $this->model = Supplier::class;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id']);

        return $this->listResponse($query->smartPaginate());
    }

    public function store(SupplierRequest $request)
    {
        $request->validated();
        $request['previous_due'] = $request['previous_due']?$request['previous_due']:0.00;
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(SupplierRequest $request, $id)
    {
        $request->validated();
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }
}
