<?php

namespace Modules\Core\Models;

use Modules\Core\Models\BaseModel;

class Branch extends BaseModel
{
    protected $fillable = ['name', 'contact_no', 'logo'];

    protected array $searchable = ['name', 'contact_no'];
}
