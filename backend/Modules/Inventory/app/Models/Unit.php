<?php

namespace Modules\Inventory\Models;


class Unit extends InvBaseModel
{
    protected $fillable = ['name','short_code', 'branch_id'];

    protected array $searchable = ['name','short_code'];
}
