<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class EmployeeType extends HrmBaseModel
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
        static::creating(function ($employeeType) {
            if (empty($employeeType->slug)) {
                $employeeType->slug = Str::slug($employeeType->name);
            }
        });

        static::updating(function ($employeeType) {
            if ($employeeType->isDirty('name')) {
                $employeeType->slug = Str::slug($employeeType->name);
            }
        });
    }
}
