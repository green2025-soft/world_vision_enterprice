<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;

class OpcacheClear extends Command
{
 protected $signature = 'opcache:clear';
    protected $description = 'Clear PHP Opcache';

    public function handle()
    {
        if (function_exists('opcache_reset')) {
            opcache_reset();
            $this->info('Opcache cleared successfully.');
        } else {
            $this->error('Opcache is not enabled.');
        }
    }
}
