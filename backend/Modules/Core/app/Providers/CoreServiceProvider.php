<?php

namespace Modules\Core\Providers;

use Illuminate\Support\ServiceProvider;

class CoreServiceProvider extends ServiceProvider
{
    protected string $name = 'Core';
    protected string $nameLower = 'core';

    // Enable deferred loading
    protected $defer = true;

    public function register(): void
    {
        // Lazy load config
        $this->app->singleton('core.config', function () {
            return $this->loadConfig();
        });

        // Register essential providers
        $this->app->register(EventServiceProvider::class);
        $this->app->register(RouteServiceProvider::class);

        // Optional helpers
        require_once __DIR__ . '/../Helpers/core_helper.php';
    }

    public function boot(\Illuminate\Routing\Router $router): void
    {
        // Register API-specific middleware only
        $router->middlewareGroup('admin', [\Modules\Core\Http\Middleware\AdminMiddleware::class]);
        $router->middlewareGroup('public.cors', [\Modules\Core\Http\Middleware\PublicCorsMiddleware::class]);

        // Skip views and translations in API app
        $this->loadMigrationsFrom(module_path($this->name, 'database/migrations'));
    }

    /**
     * Load module config lazily
     */
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

    /**
     * Deferred services
     */
    public function provides(): array
    {
        return ['core.config'];
    }
}
