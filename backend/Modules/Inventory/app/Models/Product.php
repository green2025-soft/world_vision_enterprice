<?php

namespace Modules\Inventory\Models;


class Product extends InvBaseModel
{
protected $table = 'inv_products';

    protected $fillable = [
        'name', 'sku', 'category_id', 'unit_id', 'brand_id',
        'purchase_price', 'selling_price', 'stock_quantity',
        're_order', 'made_by', 'image', 'specification',
        'status', 'branch_id'
    ];

    protected array $searchable = ['name', 'sku'];

    protected array $searchableRelations = [
        'category' => 'name',
        'unit' => 'name',
        'brand' => 'name',
    ];

    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    public function unit()
    {
        return $this->belongsTo(Unit::class, 'unit_id');
    }

    public function brand()
    {
        return $this->belongsTo(Brand::class, 'brand_id');
    }

}
