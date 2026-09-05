<?php

namespace Modules\Hrm\Models;

use Illuminate\Support\Str;
class BloodGroup extends HrmBaseModel
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
        static::creating(function ($bloodGroup) {
            if (empty($bloodGroup->slug)) {
                $bloodGroup->slug = Str::slug($bloodGroup->name);
            }
        });

        static::updating(function ($bloodGroup) {
            if ($bloodGroup->isDirty('name')) {
                $bloodGroup->slug = Str::slug($bloodGroup->name);
            }
        });
    }
}
