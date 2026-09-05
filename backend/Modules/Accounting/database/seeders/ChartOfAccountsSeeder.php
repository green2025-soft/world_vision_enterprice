<?php

namespace Modules\Accounting\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Accounting\Models\AccountHead;

class ChartOfAccountsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $accounts = [
        ['code' => '110000', 'name' => 'Fixed Assets', 'type' => 'asset', 'is_debit' => true, 'parent_id' => 1],
        ['code' => '120000', 'name' => 'Current Assets', 'type' => 'asset', 'is_debit' => true, 'parent_id' => 1],

        ['code' => '210000', 'name' => 'Equity', 'type' => 'equity_liabilities', 'is_debit' => false, 'parent_id' => 2],
        ['code' => '220000', 'name' => 'Liabilities', 'type' => 'equity_liabilities', 'is_debit' => false, 'parent_id' => 2],

        ['code' => '310000', 'name' => 'General Incom', 'type' => 'income', 'is_debit' => false, 'parent_id' => 3],
        ['code' => '320000', 'name' => 'Financial Incom', 'type' => 'income', 'is_debit' => false, 'parent_id' => 3],

        ['code' => '410000', 'name' => 'General Expense', 'type' => 'expense', 'is_debit' => true, 'parent_id' => 4],
        ['code' => '420000', 'name' => 'Financial Expense', 'type' => 'expense', 'is_debit' => true, 'parent_id' => 4],
    ];

    foreach ($accounts as $account) {
        AccountHead::updateOrInsert(['code'=>$account['code']],$account);
    }

    }
}
