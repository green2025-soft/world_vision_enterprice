<?php

namespace Modules\Core\Models;

use Modules\Core\Models\BaseModel;

class Module extends BaseModel
{
    protected $fillable = ['name', 'slug', 'status'];
    
    protected array $searchable = ['name', 'slug'];

    public function permissionGroups(){
         return $this->hasMany(PermissionGroup::class, 'module_id', 'id');
    }


}