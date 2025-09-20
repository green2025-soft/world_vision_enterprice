<?php

namespace Modules\Inventory\Models;


class ProductSet extends InvBaseModel
{
    protected $fillable = ['name', 'discount', 'branch_id'];

    protected array $searchable = ['name'];

    public function items()
    {
        return $this->hasMany(ProductSetItem::class, 'product_set_id');
    }

    public function products(){
        return $this->hasManyThrough(
            Product::class,
            ProductSetItem::class,
            'product_set_id', // Foreign key on ProductSetItem
            'id',             // Local key on Product
            'id',             // Local key on ProductSet
            'product_id'      // Foreign key on ProductSetItem pointing to Product
        );
    
    }
}
