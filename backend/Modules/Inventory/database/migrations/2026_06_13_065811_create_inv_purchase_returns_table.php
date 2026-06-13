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
        Schema::create('inv_purchase_returns', function (Blueprint $table) {
            $table->id();
            $table->string('invoice_no')->unique();
            $table->foreignId('purchase_id')->constrained('inv_purchases')->onDelete('cascade');
             $table->foreignId('supplier_id')->constrained('inv_suppliers')->onDelete('cascade');
            $table->date('return_date');
            $table->decimal('total_return_amount', 12, 2)->default(0);
            $table->decimal('total_refund_amount', 12, 2)->default(0);
            $table->decimal('adjusted_due_amount', 12, 2)->default(0);
            $table->decimal('cash_refund_amount', 12, 2)->default(0);
            $table->decimal('supplier_advance', 12, 2)->default(0);
            $table->text('note')->nullable();
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->foreignId('created_by')->nullable()->constrained('users');
            $table->enum('status', ['pending', 'approved', 'rejected'])->default('approved');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_purchase_returns');
    }
};
