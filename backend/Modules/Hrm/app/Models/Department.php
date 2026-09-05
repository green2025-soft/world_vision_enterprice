<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class Department extends HrmBaseModel
{
    protected $fillable = [
        'name',
        'short_name',
        'slug',
        'branch_id ',
        'status',
    ];

    protected array $searchable = [
        'name',
        'short_name'
    ];

    protected static function booted(): void
    {
        static::creating(function ($department) {
            if (empty($department->slug)) {
                $department->slug = Str::slug($department->name);
            }
        });

        static::updating(function ($department) {
            if ($department->isDirty('name')) {
                $department->slug = Str::slug($department->name);
            }
        });
    }
}
