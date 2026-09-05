<?php

namespace Modules\Hrm\Models;

// use Illuminate\Support\Str;
class leaveDetails extends HrmBaseModel
{
    protected $fillable = [
        'leave_id',
        'employee_id',
        'department_id',
        'designation_id',
        'leave_category_id',
        'application_date',
        'leave_date',
        'status',
    ];

    protected array $searchable = [
        'leave_id',
        'employee_id',
        'department_id',
        'designation_id',
        'leave_category_id',
        'application_date',
        'leave_date',
        'status'
    ];

    protected static function booted(): void
    {
        // static::creating(function ($leaveDetails) {
        //     if (empty($leaveDetails->slug)) {
        //         $leaveDetails->slug = Str::slug($leaveDetails->name);
        //     }
        // });

        // static::updating(function ($leaveDetails) {
        //     if ($leaveDetails->isDirty('name')) {
        //         $leaveDetails->slug = Str::slug($leaveDetails->name);
        //     }
        // });
    }
}
