<?php

namespace Modules\Inventory\Models;


class Brand extends InvBaseModel
{
    protected $fillable = ['name', 'branch_id'];

    protected array $searchable = ['name'];
}
