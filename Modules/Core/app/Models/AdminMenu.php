<?php

namespace Modules\Core\Models;

use Modules\Core\Models\BaseModel;

class AdminMenu extends BaseModel
{
    protected $fillable = ['title','module_id', 'route', 'icon', 'parent_id', 'sequence', 'permission_route', 'status'];

    protected array $searchable = [];


     public function parent()
    {
        return $this->belongsTo(AdminMenu::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(AdminMenu::class, 'parent_id')->orderBy('sequence');
    }

    public function childrenRecursive()
    {
        return $this->children()->with('childrenRecursive');
    }

    public function scopeOrdered($query)
    {
        return $query->orderBy('sequence', 'asc');
    }

     public function module()
    {
        return $this->belongsTo(Module::class, 'module_id');
    }
}
