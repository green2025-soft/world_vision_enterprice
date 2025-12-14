<?php

namespace Modules\Inventory\Providers;

use Illuminate\Support\ServiceProvider;

class InventoryServiceProvider extends ServiceProvider
{
    protected string $name = 'Inventory';
    protected string $nameLower = 'inventory';

    protected $defer = true; // Lazy load

    public function register(): void
    {
        // Only register essential services
        $this->app->register(RouteServiceProvider::class);
        $this->app->register(EventServiceProvider::class);

        // Lazy load config if needed
        $this->app->singleton('inventory.config', function () {
            return $this->loadConfig();
        });
    }

    public function boot(): void
    {
        // Skip views, translations, Blade for API app
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
        return ['inventory.config'];
    }
}
