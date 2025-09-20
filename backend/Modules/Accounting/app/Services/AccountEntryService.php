<?php

namespace Modules\Accounting\Services;

use Illuminate\Support\Facades\DB;
use Modules\Accounting\Models\JournalEntry;
use Modules\Accounting\Models\JournalEntryDetail;
use Modules\Accounting\Models\AccountBalance;
use Modules\Accounting\Models\AuditLog;
use Illuminate\Support\Str;
class AccountEntryService
{
    /**
     * Create a new journal entry.
     */
    public function createEntry(array $data): JournalEntry
    {
        return DB::transaction(function () use ($data) {
            $this->validateBalancedEntry($data['lines']);

            $entryData = $this->prepareEntryData($data);
            $entry = JournalEntry::create($entryData);

            $this->storeDetailsAndUpdateBalance($entry, $data['lines'], $entryData['date']);

            AuditLog::record('Created ' . ucfirst($entry->voucher_type) . ' Entry', [
                'journal_entry_id' => $entry->id,
                'data'             => $entry->toArray() + ['lines' => $data['lines']],
            ], $entry->reference);

            return $entry;
        });
    }

    /**
     * Update an existing journal entry.
     */
    public function updateEntry(int $entryId, array $data): JournalEntry
    {
        return DB::transaction(function () use ($entryId, $data) {
            $entry = JournalEntry::with('details')->findOrFail($entryId);

            $this->validateBalancedEntry($data['lines']);

            $oldData = $entry->toArray();
            $oldData['lines'] = $entry->details->toArray();

            $this->reverseEntryDetails($entry);

            $entry->update($this->prepareEntryData($data));

            $this->storeDetailsAndUpdateBalance($entry, $data['lines'], $entry->date);

            AuditLog::record('Updated ' . ucfirst($entry->voucher_type) . ' Entry', [
                'journal_entry_id' => $entry->id,
                'old'              => $oldData,
                'new'              => $entry->toArray() + ['lines' => $data['lines']],
            ], $entry->reference);

            return $entry;
        });
    }

    /**
     * Delete a journal entry and reverse balances.
     */
    public function deleteEntry(int $entryId): bool
    {
        return DB::transaction(function () use ($entryId) {
            $entry = JournalEntry::with('details')->findOrFail($entryId);

            $logData = $entry->toArray();
            $logData['lines'] = $entry->details->toArray();

            $this->reverseEntryDetails($entry);
            $entry->delete();

            AuditLog::record('Deleted ' . ucfirst($entry->voucher_type) . ' Entry', [
                'journal_entry_id' => $entryId,
                'data'             => $logData,
            ], $entry->reference);

            return true;
        });
    }

    /**
     * Prepare journal entry header data.
     */
    protected function prepareEntryData(array $data): array
    {
        $voucherType    = $data['voucher_type'] ?? 'Journal Voucher';
        $words          = preg_split('/[\s_]+/', strtolower($voucherType));
        $prefix         =  collect($words)
        ->map(fn($word) => strtoupper(Str::substr($word, 0, 1)))
        ->join('');

        $totals = $this->calculateTotals($data['lines'] ?? []);
        return [
            'date'          => dbDateFormat($data['date'] ?? now()->toDateString()),
            'voucher_no'    => $data['voucher_no'] ?? $this->generateVoucherNo($prefix),
            'voucher_type'  => $data['voucher_type'] ?? 'manual',
            'reference'     => $data['reference'] ?? $this->generateReferenceNo(),
            // 'description'   => $data['description'] ?? null,
            'narration'     => $data['narration'] ?? null,
            'module'        => $data['module'] ?? null,
            'source_type'   => $data['source_type'] ?? null,
            'source_id'     => $data['source_id'] ?? null,
            'branch_id'     => $data['branch_id'] ?? null,
            'status'        => $data['status'] ?? 1,
            'debit'         => $totals['debit'], 
            'credit'        => $totals['credit'], 
            'created_by'    => auth()->id(),
        ];
    }

    /**
     * Validate that total debit equals total credit.
     */
    protected function validateBalancedEntry(array $lines): void
    {
        $debit = $credit = 0;

        foreach ($lines as $line) {
            $debit  += floatval($line['debit'] ?? 0);
            $credit += floatval($line['credit'] ?? 0);
        }

        if (round($debit, 2) !== round($credit, 2)) {
            throw new \Exception("Total debit ($debit) must equal total credit ($credit).");
        }
    }

    /**
     * Save journal details and update balances.
     */
    protected function storeDetailsAndUpdateBalance(JournalEntry $entry, array $lines, string $date): void
    {
        foreach ($lines as $line) {
            JournalEntryDetail::create([
                'journal_entry_id' => $entry->id,
                'account_head_id'  => $line['account_head_id'],
                'debit'            => $line['debit'] ?? 0,
                'credit'           => $line['credit'] ?? 0,
                'description'      => $line['description'] ?? null,
            ]);

            AccountBalance::updateBalance(
                $line['account_head_id'],
                $line['debit'] ?? 0,
                $line['credit'] ?? 0,
                $date, 
                $entry->branch_id ?? null,
            );
        }
    }

    /**
     * Reverse balances and delete details.
     */
    protected function reverseEntryDetails(JournalEntry $entry): void
    {
        foreach ($entry->details as $detail) {
            AccountBalance::updateBalance(
                $detail->account_head_id,
                -1 * $detail->debit,
                -1 * $detail->credit,
                $entry->date, 
                 $entry->branch_id ?? null,
            );
            $detail->delete();
        }
    }

    /**
     * Generate a unique voucher number.
     */
protected function generateVoucherNo($prefix = 'JV'): string
{
    $prefix = strtoupper($prefix);

    // Get last voucher with this prefix (based on number part, not ID)
    $lastVoucher = JournalEntry::where('voucher_no', 'like', "$prefix-%")
        ->orderByDesc('voucher_no') // Ordering voucher_no to catch highest one
        ->value('voucher_no');

    if ($lastVoucher && preg_match('/^' . $prefix . '-?(\d+)$/i', $lastVoucher, $matches)) {
        $nextNumber = (int) $matches[1] + 1;
    } else {
        $nextNumber = 1;
    }

    // Check for existing and loop until a unique voucher_no is found
    do {
        $voucherNo = $prefix . '-' . str_pad($nextNumber, 6, '0', STR_PAD_LEFT);
        $exists = JournalEntry::where('voucher_no', $voucherNo)->exists();
        $nextNumber++;
    } while ($exists);

    return $voucherNo;
}


    public function generateReferenceNo(): string
    {
        $lastReference = JournalEntry::orderByDesc('id')->value('reference');
        $defaultPrefix = 'REF';

        if ($lastReference && preg_match('/^([A-Za-z]+)-?(\d+)$/', $lastReference, $matches)) {
            $prefix = strtoupper($matches[1]);
            $nextNumber = (int) $matches[2] + 1;
        } else {
            $prefix = $defaultPrefix;
            $nextNumber = 1;
        }

        do {
            $referenceNo = $prefix . '-' . str_pad($nextNumber, 6, '0', STR_PAD_LEFT);
            $exists = JournalEntry::where('reference', $referenceNo)->exists();
            $nextNumber++;
        } while ($exists);

        return $referenceNo;
    }




    protected function calculateTotals(array $lines): array
    {
        $debit = $credit = 0;

        foreach ($lines as $line) {
            $debit  += floatval($line['debit'] ?? 0);
            $credit += floatval($line['credit'] ?? 0);
        }

        return [
            'debit' => round($debit, 2),
            'credit' => round($credit, 2),
        ];
    }
}
