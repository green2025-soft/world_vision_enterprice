<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class Gender extends HrmBaseModel
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
        static::creating(function ($gender) {
            if (empty($gender->slug)) {
                $gender->slug = Str::slug($gender->name);
            }
        });

        static::updating(function ($gender) {
            if ($gender->isDirty('name')) {
                $gender->slug = Str::slug($gender->name);
            }
        });
    }
}
