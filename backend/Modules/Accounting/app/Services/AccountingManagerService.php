<?php

namespace Modules\Accounting\Services;

use Modules\Accounting\Models\AccountModule;
use Modules\Accounting\Models\JournalEntry;


class AccountingManagerService
{
    protected $entryService;

    public function __construct()
    {
        $this->entryService = app(AccountEntryService::class);
    }

    /**
     * Create accounting entry from module mapping + user-selected accounts.
     */
    public function createEntryFromModule(string $moduleName, string $sourceType, int $sourceId, array $data): void
    {
        $map = AccountModule::where('module_name', $moduleName)->firstOrFail();

        if (!$map->status) return;

        $lines = [];

        foreach ($map->accounts as $account) {
            $component = $account['component'];
            $amountKey = $account['amount_source_key'] ?? strtolower(str_replace(' ', '_', $component));
       
            if ($amountKey && isset($data[$amountKey])) {
                $amount = floatval($data[$amountKey]);
            } else {
                $amount = floatval($data['amount'] ?? 0);
            }

            if ($amount <= 0) continue;

            // ✅ Account from user input
            $accountHeadId = $account->account_head_id;
            


            $lines[] = [
                'account_head_id' => $accountHeadId,
                'debit'           => $account['is_debit'] ? $amount : 0,
                'credit'          => !$account['is_debit'] ? $amount : 0,
                'description'     => $account['description'] ?? null,
            ];
        }


        if (empty($lines)) return;

        $this->entryService->createEntry([
            'date'         => now(),
            'voucher_type' => $moduleName,
            'module'       => $moduleName,
            'source_type'  => $sourceType,
            'source_id'    => $sourceId,
            'narration'    => $moduleName,
            'lines'        => $lines,
            'branch_id'    => $data['branch_id'] ?? null,
        ]);
    }

    /**
     * Delete existing journal entries for a module.
     */
    public function deleteEntryFromModule(string $moduleName, string $sourceType, int $sourceId): void
    {
        $entries = JournalEntry::where('module', $moduleName)
            ->where('source_type', $sourceType)
            ->where('source_id', $sourceId)
            ->get();

        foreach ($entries as $entry) {
            $this->entryService->deleteEntry($entry->id);
        }
    }
}
