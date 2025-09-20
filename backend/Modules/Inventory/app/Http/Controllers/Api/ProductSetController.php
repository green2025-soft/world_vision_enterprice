<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\ProductSet;
use Modules\Inventory\Http\Requests\ProductSetRequest;
use Illuminate\Http\Request;
use DB;

class ProductSetController extends BaseApiController
{
    protected string $title = 'ProductSet';

    public function __construct()
    {
        $this->model = ProductSet::class;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery()
            ->with('products', 'items')
            ->where('branch_id', $request['branch_id']);

        return $this->listResponse($query->smartPaginate());
    }

    public function store(ProductSetRequest $request)
    {
        $validated = $request->validated();
           DB::beginTransaction();
           $data = $validated;
            unset($data['items']);
            $mainData = $this->model::create($data);
            $items = $this->cleanItems($validated['items'] ?? []);
            foreach ($items as $detail) {
                $detail['branch_id'] = $data['branch_id'];
                $mainData->items()->create($detail);
            }
           DB::commit();

         return $this->createdResponse($mainData);
    }

    public function show($id)
    {
        return $this->showData($id);
    }

    public function update(ProductSetRequest $request, $id)
    {
         $validated = $request->validated();
         DB::beginTransaction();
           $data = $validated;
            unset($data['items']);
            $mainData = $this->model::findOrFail($id);
            $mainData->update($data);
            $mainData->items()->delete();
            $items = $this->cleanItems($validated['items'] ?? []);
            foreach ($items as $detail) {
                $detail['branch_id'] = $data['branch_id'];
                $mainData->items()->create($detail);
            }
           DB::commit();

        return $this->updatedResponse($mainData);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }

    protected function cleanItems(array $items): array
    {
        $cleaned = [];

        foreach ($items as $item) {
            $productId = $item['product_id'];

            if (!isset($cleaned[$productId])) {
                $cleaned[$productId] = $item;
            } else {
                // Merge qty, optionally override price
                $cleaned[$productId]['qty'] += $item['qty'];

                // Optional: keep latest price
                $cleaned[$productId]['price'] = $item['price'] ?? $cleaned[$productId]['price'];
            }
        }

        // return as numeric array again
        return array_values($cleaned);
    }
}
