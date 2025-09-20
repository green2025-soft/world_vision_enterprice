<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Product;
use Modules\Inventory\Http\Requests\ProductRequest;
use Illuminate\Http\Request;

class ProductController extends BaseApiController
{
    protected string $title = 'Product';

    public function __construct()
    {
        $this->model = Product::class;
    }

    public function index(Request $request)
    {
        $query = $this->indexQuery()
            ->where('branch_id', $request['branch_id'])
            ->with('category:id,name', 'unit:id,name,short_code', 'brand:id,name');

        return $this->listResponse($query->smartPaginate());
    }

    public function store(ProductRequest $request)
    {
        $request->validated();
        $request['sku'] = $this->skuNo(true);
        if ($request->hasFile('upload_image')) {
            $imageUrl = uploadImage($request->file('upload_image'), 'inventory/product');
            $request['image'] = $imageUrl;
        }
        return $this->saveData($request);
    }

    public function show($id)
    {
        return $this->showData($id, ['category', 'unit', 'brand']);
    }

    public function update(ProductRequest $request, $id)
    {
        $request->validated();
        if ($request->hasFile('upload_image')) {
             $data = $this->model::findOrFail($id);
            $imageUrl = uploadImage($request->file('upload_image'), 'inventory/product', $data->image);
             $request['image'] = $imageUrl;
        }
        return $this->updateData($request, $id);
    }

    public function destroy($id)
    {
        return $this->destroyData($id);
    }

    public function skuNo($isController=false){
      $lastSkuNo = $this->model::orderByDesc('id')->value('sku');
      $newSkuNoInt = (int) $lastSkuNo + 1;
      $newSkuNo = str_pad($newSkuNoInt, 5, '0', STR_PAD_LEFT);
      if($isController){
        return $newSkuNo;
      }
      return $this->successResponse($newSkuNo);
    }
}
