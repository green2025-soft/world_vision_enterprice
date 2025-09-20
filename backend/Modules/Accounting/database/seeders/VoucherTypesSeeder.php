<?php

namespace Modules\Accounting\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
class VoucherTypesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
          $voucherTypes = [
            ['code' => 'journal',  'name' => 'Journal Voucher', 'is_manual'=>true,   'description' => 'General adjusting entry'],
            ['code' => 'payment',  'name' => 'Payment Voucher', 'is_manual'=>true,   'description' => 'Outgoing payment'],
            ['code' => 'receipt',  'name' => 'Receipt Voucher', 'is_manual'=>true,    'description' => 'Incoming payment'],
            ['code' => 'sales',    'name' => 'Sales Voucher',  'is_manual'=>false,    'description' => 'Sales invoice related'],
            ['code' => 'purchase', 'name' => 'Purchase Voucher', 'is_manual'=>false,   'description' => 'Purchase invoice related'],
            ['code' => 'contra',   'name' => 'Contra Voucher', 'is_manual'=>true,    'description' => 'Cash to bank or bank to cash'],
            ['code' => 'credit_note', 'name' => 'Credit Note', 'is_manual'=>false,    'description' => 'Sales return or discount'],
            ['code' => 'debit_note',  'name' => 'Debit Note', 'is_manual'=>false,     'description' => 'Purchase return or extra billing'],
        ];

            foreach ($voucherTypes as $type) {
            DB::table('acc_voucher_types')->updateOrInsert(
                ['code' => $type['code']],
                [
                    'name'          => $type['name'],
                    'description'   => $type['description'],
                    'is_manual'     => $type['is_manual'],
                    'is_active'     => true,
                    'created_at'    => now(),
                    'updated_at'    => now(),
                ]
            );
        }
    }
}
