<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration {
    public function up(): void
    {
        $root = DB::table('acc_account_heads')->where('code', '200000')->whereNull('parent_id')->value('id');
        if ($root && !DB::table('acc_account_heads')->where('system_key', 'equity_funds')->exists()) {
            DB::table('acc_account_heads')->where('parent_id', $root)->where('code', '210000')->whereNull('system_key')->update(['system_key' => 'equity_funds']);
        }
    }
    public function down(): void
    {
        DB::table('acc_account_heads')->where('system_key', 'equity_funds')->update(['system_key' => null]);
    }
};
