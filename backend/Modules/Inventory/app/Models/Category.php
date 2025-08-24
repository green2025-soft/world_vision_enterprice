<?php

namespace Modules\Inventory\Models;


class Category extends InvBaseModel
{
    protected $fillable = ['name', 'branch_id'];

    protected array $searchable = ['name'];
}
