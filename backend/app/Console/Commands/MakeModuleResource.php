<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Str;

class MakeModuleResource extends Command
{
    protected $signature = 'make:module-resource {module} {name}';
    protected $description = 'Create a resource (Model, Controller, Request, Route) inside a module';

    public function handle()
    {
        $module = Str::studly($this->argument('module'));    // Blog
        $name = Str::studly($this->argument('name'));        // Post
        $lower = Str::kebab($name);                          // post
        $basePath = base_path("Modules/{$module}/app");

        // Create folders if not exist
        $paths = [
            "{$basePath}/Models",
            "{$basePath}/Controllers/Api",
            "{$basePath}/Requests",
        ];

        foreach ($paths as $path) {
            if (!File::exists($path)) {
                File::makeDirectory($path, 0755, true);
            }
        }

        $replace = [
            'DummyModule' => $module,
            'DummyClass' => $name,
            'dummymodule' => $lower,
        ];

        $this->createFromStub('model', "{$basePath}/Models/{$name}.php", $replace);
        $this->createFromStub('controller', "{$basePath}/Http/Controllers/Api/{$name}Controller.php", $replace);
        $this->createFromStub('request', "{$basePath}/Http/Requests/{$name}Request.php", $replace);

        // Append route if routes.php exists
        $routePath = "{$basePath}/routes.php";
        if (!File::exists($routePath)) {
            File::put($routePath, "<?php\n\nuse Illuminate\\Support\\Facades\\Route;\n\n");
        }

        $routeContent = "\nRoute::apiResource('{$lower}', \\Modules\\{$module}\\Controllers\\Api\\{$name}Controller::class);";
        File::append($routePath, $routeContent);

        $this->info(" Resource '{$name}' created inside module '{$module}'!");
    }

  protected function createFromStub($type, $dest, $replace)
{
    $stubPath = base_path("stubs/module/{$type}.stub");

    if (!File::exists($stubPath)) {
        $this->error(" Stub not found: {$type}.stub (Path: {$stubPath})");
        return;
    }

    $content = File::get($stubPath);
    foreach ($replace as $key => $value) {
        $content = str_replace($key, $value, $content);
    }

    File::put($dest, $content);
    $this->info(" Created: {$dest}");
}


}
