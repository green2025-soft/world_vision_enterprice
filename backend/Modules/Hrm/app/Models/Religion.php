<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class Religion extends HrmBaseModel
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
        static::creating(function ($religion) {
            if (empty($religion->slug)) {
                $religion->slug = Str::slug($religion->name);
            }
        });

        static::updating(function ($religion) {
            if ($religion->isDirty('name')) {
                $religion->slug = Str::slug($religion->name);
            }
        });
    }
}
