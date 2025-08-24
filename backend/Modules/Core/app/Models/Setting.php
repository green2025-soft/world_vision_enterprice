<?php

namespace Modules\Core\Models;

use Modules\Core\Models\BaseModel;

class Setting extends BaseModel
{
    protected $fillable = ['key', 'value', 'type'];
    
    protected array $searchable = [];
}