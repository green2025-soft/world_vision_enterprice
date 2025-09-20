<?php

namespace Modules\Accounting\Models;


class JournalEntry extends AccBaseModel
{
    protected $fillable = ['voucher_type', 'date', 'reference', 'voucher_no', 'module', 'source_type', 'source_id', 'narration', 'created_by', 'approved_by', 'debit', 'credit', 'status', 'branch_id'];

    protected array $searchable = [];

    public function details()
    {
        return $this->hasMany(JournalEntryDetail::class, 'journal_entry_id');
    }


    public static function generateVoucherNo($prefix = 'JV'): string
    {
        $lastId = JournalEntry::where('voucher_type', $prefix)
                    ->orderByDesc('id')
                    ->value('id');

        $nextId = $lastId ? $lastId + 1 : 1;

        return $prefix . '-' . str_pad($nextId, 6, '0', STR_PAD_LEFT);
    }

}
