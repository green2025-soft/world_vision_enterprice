<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class EmployeeStatus extends HrmBaseModel
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
        static::creating(function ($employeeStatus) {
            if (empty($employeeStatus->slug)) {
                $employeeStatus->slug = Str::slug($employeeStatus->name);
            }
        });

        static::updating(function ($employeeStatus) {
            if ($employeeStatus->isDirty('name')) {
                $employeeStatus->slug = Str::slug($employeeStatus->name);
            }
        });
    }
}
