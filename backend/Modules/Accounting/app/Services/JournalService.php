<?php

namespace Modules\Accounting\Services;

use Illuminate\Support\Facades\Log;
use Modules\Accounting\Models\AccountModule;
use Modules\Accounting\Models\JournalEntry;
use PgSql\Lob;

class JournalService
{
    public function __construct(protected JournalEntryService $entryService)
    {
    }

    public function create(string $feature_key, string $module_key,  int $sourceId, array $data = [] ): JournalEntry|array|null 
    {
       

        $module = AccountModule::with('accounts')->where(['feature_key'=>$feature_key, 'module_key'=>$module_key])->where('status', true)->first();

        if (!$module) {
            return null;
        }

        $lines = $this->buildLines($module, $data);

        // Log::info( $lines ); dd();

        if (empty($lines)) {
            return null;
        }
        $sourceType = $feature_key;
        $this->deleteBySource($module->module_key, $sourceType, $sourceId);
        if ($feature_key === 'stock_transfer') {
            return $this->createTransfer($module, $sourceId,$data,$lines);
        }

        return $this->entryService->create([
            'date'         => $data['date'] ?? now(),
            'voucher_type' => $module->entry_type ?? $module->module_name??$type,
            'module'       => $module->module_key,
            'source_type'  => $sourceType,
            'source_id'    => $sourceId,
            'narration'    => $data['narration'] ?? $module->description??$module->module_name,
            'branch_id'    => $data['branch_id'] ?? null,
            'lines'        => $lines,
        ]);
    }

    protected function buildLines(AccountModule $module,array $data): array 
    {
        $lines = [];

        foreach ($module->accounts as $mapping) {
            $component  = $mapping->component;
            

            $amountKey =  $mapping->amount_source_key?: $component;
            $amount = (float) ($data[$amountKey] ?? 0);

            if ($amount <= 0) continue;

            $accountId = $data['accounts'][$component] ?? $mapping->account_head_id;

            if (!$accountId) continue;
             $isDebit = (bool) $mapping->is_debit;

            $lines[$component] = [
                'ledger_account_id' => $accountId,
                'debit'             => $isDebit ? $amount : 0,
                'credit'            => $isDebit ? 0 : $amount,
                'remarks'           => $mapping->description ?? null,
            ];
        }

        return $lines;
    }

    protected function createTransfer( AccountModule $module,  int $sourceId,array $data,array $lines): array 
    {
        $inComponents = [
            'inventory_transfer_in',
            'git_transfer_in',
        ];

        $fromLines  = [];
        $toLines    = [];

        foreach ($lines as $component => $line) {
            in_array($component, $inComponents, true)? $toLines[] = $line : $fromLines[] = $line;
        }

        if (empty($fromLines) || empty($toLines)) return [];

        $base = [
            'date'         => $data['date'] ?? now(),
            'voucher_type' => $module->entry_type ?? $module->module_name??$type,
            'module'       => 'inventory',
            'source_type'  => 'stock_transfer',
            'source_id'    => $sourceId,
            'narration'    => $data['narration'] ?? $module->description ?? $module->module_name,
        ];

        $from = $this->entryService->create([
            ...$base,
            'branch_id' => $data['from_branch_id'] ?? null,
            'lines'     => $fromLines,
        ]);

        $to = $this->entryService->create([
            ...$base,
            'branch_id' => $data['to_branch_id'] ?? null,
            'lines'     => $toLines,
        ]);

        return [
            'from' => $from,
            'to'   => $to,
        ];
    }

    public function deleteBySource(string $moduleName, string $sourceType, int $sourceId) : bool
    {

        $entries = JournalEntry::query()
            ->where('module', $moduleName)
            ->where('source_type', $sourceType)
            ->where('source_id', $sourceId)
            ->get();

             $deleted = true;

        foreach ($entries as $entry) {
             $deleted = $this->entryService->delete($entry->id);
        }

        return $deleted;
         

    }
}
