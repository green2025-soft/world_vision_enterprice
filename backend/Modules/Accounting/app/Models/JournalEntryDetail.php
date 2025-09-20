<?php

namespace Modules\Accounting\Models;


class JournalEntryDetail extends AccBaseModel
{
    protected $fillable = ['journal_entry_id', 'account_head_id', 'debit', 'credit', 'remarks'];


    public function accountHead()
    {
        return $this->belongsTo(AccountHead::class, 'account_head_id');
    }
}
