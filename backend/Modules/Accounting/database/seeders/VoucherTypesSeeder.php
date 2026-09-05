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
            ['code' => 'receipt',  'name' => 'Receipt Voucher', 'is_manual'=>true,    'description' => 'Incoming'],
            ['code' => 'payment',  'name' => 'Payment Voucher', 'is_manual'=>true,   'description' => 'Outgoing'],
            ['code' => 'journal',  'name' => 'Journal Voucher', 'is_manual'=>true,   'description' => 'Non Cash'],
            ['code' => 'contra',   'name' => 'Contra Voucher', 'is_manual'=>true,    'description' => 'Cash to bank or bank to cash']
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
