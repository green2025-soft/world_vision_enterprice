<?php

namespace Modules\Core\Models;

use Modules\Core\Models\BaseModel;

class ModuleSection extends BaseModel
{
    protected $fillable = [ 'section_name', 'module_id', 'section_action_route', 'section_roles_permission'];
    
    protected array $searchable = [];

    
}