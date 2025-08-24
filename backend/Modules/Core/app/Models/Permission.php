<?php

namespace Modules\Core\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Modules\Core\Models\BaseModel;

class Permission extends BaseModel
{
    use HasFactory;


    protected $fillable = [
        'name','guard_name','group_id'
    ];


    public function group(){
        return $this->belongsTo(PermissionGroup::class);
    }

}
