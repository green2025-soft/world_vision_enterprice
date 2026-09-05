<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class Shift extends HrmBaseModel
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
        static::creating(function ($shift) {
            if (empty($shift->slug)) {
                $shift->slug = Str::slug($shift->name);
            }
        });

        static::updating(function ($shift) {
            if ($shift->isDirty('name')) {
                $shift->slug = Str::slug($shift->name);
            }
        });
    }
}
