<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('acc_module_entry_accounts', function (Blueprint $table) {
            $table->id();

            $table->foreignId('module_entry_id')
                ->constrained('acc_module_entries')
                ->onDelete('cascade');

            $table->string('component')->comment('Component name like revenue, vat, discount');
            $table->foreignId('account_head_id')
                ->constrained('acc_account_heads')
                ->onDelete('restrict');

            $table->boolean('is_debit')->default(false)->comment('True = debit, False = credit');
            $table->string('description')->nullable();

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('acc_module_entry_accounts');
    }
};
