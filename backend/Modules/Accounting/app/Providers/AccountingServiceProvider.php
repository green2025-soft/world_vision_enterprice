<?php

namespace Modules\Accounting\Providers;

use Illuminate\Support\ServiceProvider;

class AccountingServiceProvider extends ServiceProvider
{
    protected string $name = 'Accounting';
    protected string $nameLower = 'accounting';

    // Lazy load the provider
    protected $defer = true;

    public function register(): void
    {
        // Only load config when needed
        $this->app->singleton('accounting.config', function () {
            return $this->loadConfig();
        });

        // Only essential providers
        $this->app->register(EventServiceProvider::class);
        $this->app->register(RouteServiceProvider::class);
    }

    public function boot(): void
    {
        // Only migrations (no views, no translations)
        $this->loadMigrationsFrom(module_path($this->name, 'database/migrations'));
    }

    protected function loadConfig(): array
    {
        $configPath = module_path($this->name, 'Config');
        $configs = [];
        if (is_dir($configPath)) {
            foreach (glob($configPath.'/*.php') as $file) {
                $configs[$this->nameLower.'.'.basename($file, '.php')] = require $file;
            }
        }
        return $configs;
    }

    public function provides(): array
    {
        return ['accounting.config'];
    }
}
