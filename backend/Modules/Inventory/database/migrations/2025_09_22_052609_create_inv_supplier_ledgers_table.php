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
        Schema::create('inv_supplier_ledgers', function (Blueprint $table) {
            $table->id();
            $table->foreignId('supplier_id')->constrained('inv_suppliers')->onDelete('cascade');
            $table->date('date')->index();
            $table->enum('transaction_type', ['opening_balance','advance','purchase','payment','advance_adjust','adjustment','purchase_return','due_payment','due_payment_adjust','return_due_adjust','return_advance_adjust','return_cash_refund','return_advance','tex_amount']);
            $table->decimal('debit', 15, 2)->default(0);
            $table->decimal('credit', 15, 2)->default(0);
            $table->decimal('balance', 15, 2)->nullable();
            $table->bigInteger('reference_id')->unsigned();
            $table->string('reference_no')->nullable();
            $table->text('note')->nullable();
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_supplier_ledgers');
    }
};
