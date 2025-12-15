<?php

namespace Modules\Inventory\Http\Controllers\Api;
use Modules\Core\Http\Controllers\Api\BaseApiController;

use Modules\Inventory\Models\Product;
use Modules\Inventory\Http\Requests\ProductRequest;
use Illuminate\Http\Request;
use Modules\Inventory\Models\PriceList;
use Modules\Inventory\Models\StockBalance;

use Illuminate\Support\Facades\DB;

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

  public function getInventoryProducts(Request $request, $id=null)
    {
        $branchId   = $request->input('branch_id');
        $categoryId = $request->input('category_id');
        $isStock    = $request->input('isStock');

        $productTable = (new Product())->getTable(); // ✅ Table name dynamically

        $query = $this->indexQuery();
        if ($id){
            $query->where('id',$id); 
        }else{
          $query->where('status',1);  
        }
        if($categoryId){
            $query->where('category_id',$categoryId); 
        }
        $query->select('id','name', 'sku', 'category_id', 'unit_id', 'brand_id', 're_order', 'image', 'made_by', 'specification')
        ->where('branch_id', $branchId)
        
        ->with(['category:id,name', 'unit:id,name,short_code', 'brand:id,name'])
        ->addSelect([
            // Current Stock from StockBalance
            'current_stock' => StockBalance::select('current_stock')
                ->whereColumn('product_id', "$productTable.id")
                ->where('branch_id', $branchId)
                ->limit(1),

            // Latest purchase price
            'purchase_price' => PriceList::select('price')
                ->whereColumn('product_id', "$productTable.id")
                ->where('price_type', 'purchase')
                ->where('branch_id', $branchId)
                ->orderByDesc('start_date')
                ->limit(1),



            // Latest sale price
            'sale_price' => PriceList::select('price')
                ->whereColumn('product_id', "$productTable.id")
                ->where('price_type', 'sale')
                ->where('branch_id', $branchId)
                ->orderByDesc('start_date')
                ->limit(1),


        ]);

      if ($isStock) {
            $stockTable = (new StockBalance())->getTable();

            $query->whereExists(function ($q) use ($branchId, $productTable, $stockTable) {
                $q->selectRaw(1)
                ->from($stockTable)
                ->whereColumn("$stockTable.product_id", "$productTable.id")
                ->where("$stockTable.branch_id", $branchId)
                ->where("$stockTable.current_stock", '>', 0);
            });
        }

        

        // Smart paginate
        $products = $query->smartPaginate();

        // Done! No transformation or extra queries needed
        return $this->listResponse($products);
    }

}
