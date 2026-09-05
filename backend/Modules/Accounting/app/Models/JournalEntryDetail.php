<?php

namespace Modules\Accounting\Models;

class JournalEntryDetail extends AccBaseModel
{
    protected $fillable = [
        'journal_entry_id', 'account_type_id', 'account_category_id', 'control_group_id', 'ledger_group_id', 'ledger_account_id', 'debit', 'credit', 'remarks'
    ];

    public function journalEntry()
    {
        return $this->belongsTo(JournalEntry::class, 'journal_entry_id');
    }

    public function accountType()
    {
        return $this->belongsTo(AccountHead::class, 'account_type_id');
    }

    public function accountCategory()
    {
        return $this->belongsTo(AccountHead::class, 'account_category_id');
    }

    public function controlGroup()
    {
        return $this->belongsTo(AccountHead::class, 'control_group_id');
    }

    public function ledgerGroup()
    {
        return $this->belongsTo(AccountHead::class, 'ledger_group_id');
    }

    public function ledgerAccount()
    {
        return $this->belongsTo(AccountHead::class, 'ledger_account_id');
    }
}
