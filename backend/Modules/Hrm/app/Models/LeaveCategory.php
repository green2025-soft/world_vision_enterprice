<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class LeaveCategory extends HrmBaseModel
{
    protected $fillable = [
        'name',
        'short_name',
        'leave_limit',
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
        static::creating(function ($leaveCategory) {
            if (empty($leaveCategory->slug)) {
                $leaveCategory->slug = Str::slug($leaveCategory->name);
            }
        });

        static::updating(function ($leaveCategory) {
            if ($leaveCategory->isDirty('name')) {
                $leaveCategory->slug = Str::slug($leaveCategory->name);
            }
        });
    }
}
