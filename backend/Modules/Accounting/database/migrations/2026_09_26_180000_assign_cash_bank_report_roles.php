<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    public function up(): void
    {
        foreach (['121100' => 'cash_in_hand', '121200' => 'cash_at_bank'] as $code => $key) {
            if (!DB::table('acc_account_heads')->where('system_key', $key)->exists()) {
                DB::table('acc_account_heads')->where('code', $code)->where('type', 'asset')->whereNull('system_key')->update(['system_key' => $key]);
            }
        }
    }
    public function down(): void
    {
        DB::table('acc_account_heads')->whereIn('system_key', ['cash_in_hand', 'cash_at_bank'])->update(['system_key' => null]);
    }
};
