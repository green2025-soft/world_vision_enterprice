<?php

namespace Modules\Accounting\Services;

use Nwidart\Modules\Facades\Module;
use Modules\Accounting\Models\AccountModule;

use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Pagination\Paginator;

class AccountingConfigService
{
    public function all(): array
    {
        $configs = [];

        foreach (Module::all() as $module) {
            if (!$module->isEnabled()) {
                continue;
            }

            $path = module_path($module->getName(), 'config/accounting');

            if (!is_dir($path)) {
                continue;
            }

            foreach (glob($path . '/*.php') as $file) {
                $key = pathinfo($file, PATHINFO_FILENAME);
                $config = require $file;

                $accountModule = AccountModule::with('accountHeads')
                    ->where('feature_key', $key)
                    ->where('status', true)
                    ->first(); 

                if ($accountModule) {
                    $config['name'] = $accountModule->module_name;
                    $config['entry_type'] = $accountModule->entry_type;
                }
                    

                $configs[$key] = [
                    ...$config,
                    'key'      => $key,
                    'module'   => $module->getName(),
                    'account'   => $accountModule
                ];
            }
        }

        return $configs;
    }


public function get(string $type): ?array
{
    $config = $this->all()[$type] ?? null;

    if (!$config) {
        return null;
    }

    $accountModule = AccountModule::with('accounts')
        ->where('feature_key', $type)
        ->where('status', true)
        ->first();

    if (!$accountModule) {
        return $config;
    }
    $config['name']         = $accountModule->module_name;
    $config['entry_type']   = $accountModule->entry_type;
    $config['description']  = $accountModule->description;
    

    $accounts = $accountModule->accounts;

    $config['components'] = collect($config['components'] ?? [])
        ->map(function (array $component) use ($accounts) {
            $account = $accounts->firstWhere(
                'component',
                $component['key']
            );
            
            return [
                ...$component,
                'account_head_id'   => $account?->account_head_id,
                'description'       => $account?->description,
            ];
        })
        ->values()
        ->all();

    return $config;
}

public function smartPaginate(): LengthAwarePaginator
{
    $page       = request()->integer('page', 1);
    $perPage    = request()->integer('per_page', 10);

    $items = $this->all();
    $collection = collect($items);

    $results = $collection
        ->forPage($page, $perPage)
        ->values();

    return new LengthAwarePaginator(
        $results,
        $collection->count(),
        $perPage,
        $page,
        [
            'path' => request()->url(),
            'query' => request()->query(),
        ]
    );
}


}
