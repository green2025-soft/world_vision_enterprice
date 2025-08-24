<?php

namespace Modules\Core\Database\Seeders;

use Illuminate\Database\Seeder;


use Modules\Core\Models\Setting;

class SettingSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
      $settings = [
        ['key' => 'app_name',         'value' => '', 'type' => 'text'],
        ['key' => 'app_title',        'value' => '', 'type' => 'text'],
        ['key' => 'app_url',          'value' => '', 'type' => 'text'],
        ['key' => 'app_email',        'value' => '', 'type' => 'text'],
        ['key' => 'app_address',      'value' => '', 'type' => 'text'],
        ['key' => 'app_contact',      'value' => '', 'type' => 'text'],
        ['key' => 'app_logo',         'value' => '', 'type' => 'text'],
        ['key' => 'icon_logo',        'value' => '', 'type' => 'text'],
        ['key' => 'currency_symbol',  'value' => '', 'type' => 'text'],
        ['key' => 'symbol_position',  'value' => '', 'type' => 'text'],
    ];

        foreach ($settings as $setting) {
            Setting::updateOrCreate(['key' => $setting['key']], $setting);
        }

       
    }
}
