<?php

namespace Modules\Inventory\Services;

use Modules\Accounting\Models\AccountModule;
use Modules\Accounting\Models\JournalEntry;
use Modules\Accounting\Services\AccountEntryService;

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
            $amount = floatval($data[$amountKey] ?? 0);

            if ($amount <= 0) continue;

            // ✅ Account from user input
            $accountHeadId = $data['user_selected_accounts'][$component] ?? null;

            if (!$accountHeadId) {
                throw new \Exception("Account not selected for: {$component}");
            }

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
            'voucher_type' => strtolower(str_replace(' ', '_', $moduleName)),
            'module'       => $moduleName,
            'source_type'  => $sourceType,
            'source_id'    => $sourceId,
            'narration'    => $moduleName . ' Accounting Entry',
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
