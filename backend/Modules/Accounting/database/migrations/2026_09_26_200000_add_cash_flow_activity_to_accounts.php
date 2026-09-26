<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('acc_account_heads', fn (Blueprint $table) => $table->string('cash_flow_activity', 20)->nullable());
        // Initial mappings for the existing chart; account IDs retain them after renaming.
        foreach ([300000 => 'operating', 400000 => 'operating', 110000 => 'investing', 120000 => 'operating', 210000 => 'financing', 221000 => 'operating', 222200 => 'operating'] as $code => $activity) {
            DB::table('acc_account_heads')->where('code', $code)->update(['cash_flow_activity' => $activity]);
        }
    }
    public function down(): void
    {
        Schema::table('acc_account_heads', fn (Blueprint $table) => $table->dropColumn('cash_flow_activity'));
    }
};
