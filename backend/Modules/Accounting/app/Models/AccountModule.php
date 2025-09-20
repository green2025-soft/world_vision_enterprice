<?php

namespace Modules\Accounting\Models;


class AccountModule extends AccBaseModel
{
    protected $table = 'acc_module_entries';
    protected $fillable = ['module_name', 'entry_type', 'description', 'status'];

    protected array $searchable = ['module_name', 'entry_type'];


    public function accounts()
    {
        return $this->hasMany(ModuleEntryAccount::class, 'module_entry_id');
    }

    public function accountHeads(){
         return $this->hasManyThrough(
            AccountHead::class,
            ModuleEntryAccount::class,
            'module_entry_id', 
            'id',            
            'id',             
            'account_head_id'      
        );
    }
}
