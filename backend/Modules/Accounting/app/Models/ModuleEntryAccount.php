<?php

namespace Modules\Accounting\Models;


class ModuleEntryAccount extends AccBaseModel
{
    protected $table = 'acc_module_entry_accounts';
    protected $fillable = ['module_entry_id', 'component', 'account_head_id', 'is_debit', 'description'];




     public function moduleEntry()
    {
        return $this->belongsTo(AccountModule::class, 'module_entry_id');
    }


    public function accountHead()
    {
        return $this->belongsTo(AccountHead::class, 'account_head_id'); 
    }



}
