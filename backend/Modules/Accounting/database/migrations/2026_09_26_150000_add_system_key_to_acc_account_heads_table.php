<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('acc_account_heads', function (Blueprint $table) {
            $table->string('system_key', 100)->nullable()->unique();
        });

        // Identify the existing account once. Reports subsequently use only its stable key.
        DB::table('acc_account_heads')
            ->where('code', '213000')
            ->whereNotNull('parent_id')
            ->whereIn('type', ['equity_liability', 'equity', 'liability'])
            ->update(['system_key' => 'income_over_expenditure']);
    }

    public function down(): void
    {
        Schema::table('acc_account_heads', function (Blueprint $table) {
            $table->dropUnique(['system_key']);
            $table->dropColumn('system_key');
        });
    }
};
