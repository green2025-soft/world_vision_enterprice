<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class Designation extends HrmBaseModel
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
        static::creating(function ($designation) {
            if (empty($designation->slug)) {
                $designation->slug = Str::slug($designation->name);
            }
        });

        static::updating(function ($designation) {
            if ($designation->isDirty('name')) {
                $designation->slug = Str::slug($designation->name);
            }
        });
    }
}
