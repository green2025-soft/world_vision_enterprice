<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class EmployeeCategory extends HrmBaseModel
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
        static::creating(function ($employeeCategory) {
            if (empty($employeeCategory->slug)) {
                $employeeCategory->slug = Str::slug($employeeCategory->name);
            }
        });

        static::updating(function ($employeeCategory) {
            if ($employeeCategory->isDirty('name')) {
                $employeeCategory->slug = Str::slug($employeeCategory->name);
            }
        });
    }
}
