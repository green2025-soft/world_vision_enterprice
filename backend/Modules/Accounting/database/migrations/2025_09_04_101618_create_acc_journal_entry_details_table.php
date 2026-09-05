<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('acc_journal_entry_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('journal_entry_id')->constrained('acc_journal_entries')->cascadeOnDelete();
            $table->foreignId('account_type_id')->constrained('acc_account_heads')->restrictOnDelete();
            $table->foreignId('account_category_id')->constrained('acc_account_heads')->restrictOnDelete();
            $table->foreignId('control_group_id')->constrained('acc_account_heads')->restrictOnDelete();
            $table->foreignId('ledger_group_id')->constrained('acc_account_heads')->restrictOnDelete();
            $table->foreignId('ledger_account_id')->constrained('acc_account_heads')->restrictOnDelete();
            $table->decimal('debit', 15, 2)->default(0);
            $table->decimal('credit', 15, 2)->default(0);
            $table->text('remarks')->nullable();
            $table->timestamps();

            $table->index([
                'account_type_id',
                'account_category_id',
                'control_group_id',
                'ledger_group_id',
                'ledger_account_id',
            ]);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('acc_journal_entry_details');
    }
};
