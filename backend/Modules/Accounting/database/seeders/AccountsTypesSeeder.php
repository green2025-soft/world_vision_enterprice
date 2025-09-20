<?php

namespace Modules\Accounting\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Accounting\Models\AccountHead;
class AccountsTypesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $types = [
            ['code' => '1000', 'name' => 'Assets',     'type' => 'asset',    'is_debit' => true],
            ['code' => '2000', 'name' => 'Liabilities','type' => 'liability','is_debit' => false],
            ['code' => '3000', 'name' => 'Equity',     'type' => 'equity',   'is_debit' => false],
            ['code' => '4000', 'name' => 'Income',     'type' => 'income',   'is_debit' => false],
            ['code' => '5000', 'name' => 'Expenses',   'type' => 'expense',  'is_debit' => true],
        ];

        foreach ($types as $type) {
             AccountHead::updateOrInsert(
                ['code' => $type['code']],
                [
                    'name'      => $type['name'],
                    'type'      => $type['type'],
                    'is_debit'  => $type['is_debit'],
                    'parent_id' => null,
                    'branch_id' => null,
                    'remarks'   => 'System generated parent account',
                ]
            );
        }
    }
}
