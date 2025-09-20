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
        Schema::create('acc_journal_entries', function (Blueprint $table) {
            $table->id();
            $table->string('voucher_type')->nullable()->index();
            $table->date('date')->index();
            $table->string('voucher_no')->unique()->nullable();
            $table->string('reference')->nullable();
            $table->string('module')->nullable()->index();       // e.g. sales, purchase
            $table->string('source_type')->nullable()->index();  // e.g. student_payment
            $table->unsignedBigInteger('source_id')->nullable();
            $table->text('narration')->nullable();
            $table->decimal('debit', 16, 2)->default(0);
            $table->decimal('credit', 16, 2)->default(0);
            $table->unsignedBigInteger('created_by');
            $table->unsignedBigInteger('approved_by')->nullable();
            $table->enum('status', ['pending', 'approved', 'rejected'])->default('pending');
            $table->foreignId('branch_id')->nullable()->constrained('branches')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('acc_journal_entries');
    }
};
