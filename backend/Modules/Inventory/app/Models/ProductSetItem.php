<?php

namespace Modules\Inventory\Models;


class ProductSetItem extends InvBaseModel
{
    protected $fillable = ['product_set_id', 'product_id', 'qty', 'price', 'branch_id'];


}
