<?php

namespace Modules\Accounting\Services;

use Illuminate\Support\Facades\DB;
use Modules\Accounting\Models\AccountBalance;
use Modules\Accounting\Models\JournalEntry;
use Modules\Accounting\Models\JournalEntryDetail;
use Modules\Accounting\Models\AuditLog;

class JournalEntryService
{
    public function __construct(protected JournalHelperService $helper)
    {
    }

    public function create(array $data): JournalEntry
    {
        return DB::transaction(function () use ($data) {
            $lines = $data['lines'] ?? [];
            $totals = $this->helper->totals($lines);

            $voucherType = $data['voucher_type'] ?? 'Journal Voucher';

            $entry = JournalEntry::create([
                'date'         => dbDateFormat($data['date'] ?? now()),
                'voucher_type' => $voucherType,
                'voucher_no'   => $data['voucher_no'] ?? $this->helper->voucherNo($voucherType),
                'reference'    => $data['reference'] ?? $this->helper->referenceNo(),
                'module'       => $data['module'] ?? null,
                'source_type'  => $data['source_type'] ?? null,
                'source_id'    => $data['source_id'] ?? null,
                'narration'    => $data['narration'] ?? null,
                'branch_id'    => $data['branch_id'] ?? null,
                'debit'        => $totals['debit'],
                'credit'       => $totals['credit'],
                'status'       => $data['status'] ?? 1,
                'created_by'   => auth()->id(),
            ]);

            $this->storeDetails($entry, $lines);
            AuditLog::record(
                'Created ' . $entry->voucher_type . ' Entry',
                [
                    'journal_entry_id' => $entry->id,
                    'data' => $entry->toArray() + ['lines' => $lines],
                ],
                $entry->reference
            );

            return $entry->fresh('details');
        });
    }

    public function update(int $entryId, array $data): JournalEntry
    {
        return DB::transaction(function () use ($entryId, $data) {
            $entry = JournalEntry::with('details')->findOrFail($entryId);
            $oldData = $entry->toArray();
            $oldData['lines'] = $entry->details->toArray();

            $lines = $data['lines'] ?? [];
            $totals = $this->helper->totals($lines);

            $this->reverseDetails($entry);

            $entry->update([
                'date'         => dbDateFormat($data['date'] ?? $entry->date),
                'voucher_type' => $data['voucher_type'] ?? $entry->voucher_type,
                'narration'    => $data['narration'] ?? $entry->narration,
                'module'       => $data['module'] ?? $entry->module,
                'source_type'  => $data['source_type'] ?? $entry->source_type,
                'source_id'    => $data['source_id'] ?? $entry->source_id,
                'branch_id'    => $data['branch_id'] ?? $entry->branch_id,
                'debit'        => $totals['debit'],
                'credit'       => $totals['credit'],
            ]);

            $this->storeDetails($entry, $lines);

            $entry = $entry->fresh('details');
            AuditLog::record(
                'Updated ' . $entry->voucher_type . ' Entry',
                [
                    'journal_entry_id' => $entry->id,
                    'old' => $oldData,
                    'new' => $entry->toArray() + [
                        'lines' => $entry->details->toArray(),
                    ],
                ],
                $entry->reference
            );

            return $entry;
        });
    }

   public function delete(int $entryId): bool
    {
        return DB::transaction(function () use ($entryId) {

            $entry = JournalEntry::with('details')->findOrFail($entryId);

            $logData = $entry->toArray();
            $logData['lines'] = $entry->details->toArray();

            $this->reverseDetails($entry);

            $deleted = (bool) $entry->delete();

            if ($deleted) {
                AuditLog::record(
                    'Deleted ' . $entry->voucher_type . ' Entry',
                    [
                        'journal_entry_id' => $entryId,
                        'data' => $logData,
                    ],
                    $entry->reference
                );
            }

            return $deleted;
        });
    }

    protected function storeDetails(JournalEntry $entry, array $lines): void
    {
        foreach ($lines as $line) {
            $account = $this->helper->accountHierarchy($line['ledger_account_id']);

            JournalEntryDetail::create([
                'journal_entry_id'    => $entry->id,
                'account_type_id'     => $account['account_type_id'],
                'account_category_id' => $account['account_category_id'],
                'control_group_id'    => $account['control_group_id'],
                'ledger_group_id'     => $account['ledger_group_id'],
                'ledger_account_id'   => $account['ledger_account_id'],
                'debit'               => $line['debit'] ?? 0,
                'credit'              => $line['credit'] ?? 0,
                'remarks'             => $line['remarks'] ?? null,
            ]);

            AccountBalance::updateBalance(
                $account['ledger_account_id'],
                (float) ($line['debit'] ?? 0),
                (float) ($line['credit'] ?? 0),
                $entry->date,
                $entry->branch_id
            );
        }
    }

    protected function reverseDetails(JournalEntry $entry): void
    {
        foreach ($entry->details as $detail) {
            AccountBalance::updateBalance(
                $detail->ledger_account_id,
                -$detail->debit,
                -$detail->credit,
                $entry->date,
                $entry->branch_id
            );

            $detail->delete();
        }
    }

    public function generateReferenceNo(){
        return $this->helper->referenceNo();
    }
}
