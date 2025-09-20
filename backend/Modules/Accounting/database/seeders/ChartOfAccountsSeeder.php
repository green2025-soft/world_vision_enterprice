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

        ['code' => '1001', 'name' => 'Cash in Hand', 'type' => 'asset', 'is_debit' => true, 'parent_id' => 1],
        ['code' => '1002', 'name' => 'Bank Account', 'type' => 'asset', 'is_debit' => true, 'parent_id' => 1],

        ['code' => '2000', 'name' => 'Liabilities', 'type' => 'liability', 'is_debit' => false, 'parent_id' => null],
        ['code' => '2001', 'name' => 'Accounts Payable', 'type' => 'liability', 'is_debit' => false, 'parent_id' => 4],

        ['code' => '3000', 'name' => 'Equity', 'type' => 'equity', 'is_debit' => false, 'parent_id' => null],
        ['code' => '3001', 'name' => 'Owner’s Capital', 'type' => 'equity', 'is_debit' => false, 'parent_id' => 6],

        ['code' => '4000', 'name' => 'Income', 'type' => 'income', 'is_debit' => false, 'parent_id' => null],
        ['code' => '4001', 'name' => 'Sales Revenue', 'type' => 'income', 'is_debit' => false, 'parent_id' => 8],

        ['code' => '5000', 'name' => 'Expenses', 'type' => 'expense', 'is_debit' => true, 'parent_id' => null],
        ['code' => '5001', 'name' => 'Salary Expense', 'type' => 'expense', 'is_debit' => true, 'parent_id' => 10],
    ];

    foreach ($accounts as $account) {
        AccountHead::updateOrInsert(['code'=>$account['code']],$account);
    }

    }
}
