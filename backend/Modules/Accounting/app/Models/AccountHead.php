<?php

namespace Modules\Accounting\Models;


class AccountHead extends AccBaseModel
{
    protected $fillable = [
        'name', 'code', 'parent_id', 'type', 'is_debit', 'remarks', 'branch_id', 'status'
    ];

    protected array $searchable = ['name', 'code'];


    public function parent()
    {
        return $this->belongsTo(AccountHead::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(AccountHead::class, 'parent_id');
    }

    public function childrenRecursive()
    {
        return $this->children()->with('childrenRecursive');
    }
}
