<?php

namespace Modules\Accounting\Services;

use Exception;
use Illuminate\Support\Str;
use Modules\Accounting\Models\AccountHead;
use Modules\Accounting\Models\JournalEntry;

class JournalHelperService
{
    public function accountHierarchy(int $ledgerAccountId): array
    {
        $account = AccountHead::findOrFail($ledgerAccountId);
        $parents = [];

        while ($account->parent_id) {
            $parents[] = $account->parent_id;
            $account = $account->parent;
        }

        $parents = array_reverse($parents);

        if (count($parents) < 4) {
            throw new Exception("Invalid account hierarchy for account ID: {$ledgerAccountId}");
        }

        return [
            'account_type_id'     => $parents[0],
            'account_category_id' => $parents[1],
            'control_group_id'    => $parents[2],
            'ledger_group_id'     => $parents[3],
            'ledger_account_id'   => $ledgerAccountId,
        ];
    }

    public function totals(array $lines): array
    {
        if (empty($lines)) {
            throw new Exception('Journal entry must contain lines.');
        }

        $debit = $credit = 0;

        foreach ($lines as $line) {
            $debit += (float) ($line['debit'] ?? 0);
            $credit += (float) ($line['credit'] ?? 0);
        }

        if (round($debit, 2) !== round($credit, 2)) {
            throw new Exception( "Journal entry is not balanced. Debit: {$debit}, Credit: {$credit}" );
        }

        return [
            'debit'  => round($debit, 2),
            'credit' => round($credit, 2),
        ];
    }

    public function voucherNo(string $voucherType): string
    {
        $prefix = collect(preg_split('/[\s_]+/', strtolower($voucherType)))->filter()->map(fn ($word) => strtoupper(Str::substr($word, 0, 1)))->join('') ?: 'JV';

        $last = JournalEntry::where('voucher_no', 'like', "{$prefix}-%")->orderByDesc('id')->value('voucher_no');

        $next = $last && preg_match("/^{$prefix}-(\d+)$/i", $last, $match)? (int) $match[1] + 1: 1;

        do {
            $voucherNo = $prefix . '-' . str_pad($next++, 6, '0', STR_PAD_LEFT);
        } while (JournalEntry::where('voucher_no', $voucherNo)->exists());

        return $voucherNo;
    }

    public function referenceNo(): string
    {
        $last = JournalEntry::orderByDesc('id')->value('reference');

        $next = $last && preg_match('/^REF-(\d+)$/i', $last, $match)? (int) $match[1] + 1 : 1;

        do {
            $reference = 'REF-' . str_pad($next++, 6, '0', STR_PAD_LEFT);
        } while (JournalEntry::where('reference', $reference)->exists());

        return $reference;
    }
}
