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
        Schema::create('inv_payments', function (Blueprint $table) {
            $table->id();
            $table->enum('payment_type', ['in', 'out']);
            $table->string('reference_type');
            $table->unsignedBigInteger('reference_id');
            $table->decimal('amount', 12, 2);
            $table->string('payment_method')->default('cash'); 
            $table->date('payment_date');
            $table->text('note')->nullable();
            $table->foreignId('branch_id')->constrained('branches')->cascadeOnDelete();
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();

            $table->index(['reference_type', 'reference_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_payments');
    }
};
