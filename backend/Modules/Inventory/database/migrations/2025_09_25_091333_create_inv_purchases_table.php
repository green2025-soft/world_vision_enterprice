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
        Schema::create('inv_purchases', function (Blueprint $table) {
            $table->id();
            $table->string('invoice_no')->unique();
            $table->foreignId('supplier_id')->constrained('inv_suppliers')->cascadeOnDelete();
            $table->date('invoice_date')->index();
            $table->decimal('total_amount', 12, 2);

            $table->decimal('discount_percent', 5, 2)->default(0);
            $table->decimal('discount_amount', 12, 2)->default(0);
            $table->decimal('total_discount_percent', 5, 2)->default(0);
            $table->decimal('total_discount_amount', 12, 2)->default(0);

            $table->decimal('tax_percent', 5, 2)->default(0);
            $table->decimal('tax_amount', 12, 2)->default(0);
            $table->decimal('total_tax_percent', 5, 2)->default(0);
            $table->decimal('total_tax_amount', 12, 2)->default(0);

            $table->decimal('adjustment', 12, 2)->default(0);

            $table->decimal('supplier_adjust', 12, 2)->default(0);
            $table->decimal('net_total', 12, 2);
            $table->decimal('paid_amount', 12, 2)->default(0); 
            $table->decimal('due_amount', 12, 2);
            $table->text('remarks')->nullable();
            
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->foreignId('created_by')->nullable()->constrained('users');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_purchases');
    }
};
