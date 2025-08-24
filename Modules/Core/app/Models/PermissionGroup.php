<?php

namespace Modules\Core\Models;

use Modules\Core\Models\BaseModel;

class PermissionGroup extends BaseModel
{
    protected $fillable = ['name', 'module_id'];
    
    protected array $searchable = [];

    public function permissions(){
        return $this->hasMany(Permission::class, 'group_id','id');
    }

    public function module(){
        return $this->belongsTo(Module::class);
    }
}