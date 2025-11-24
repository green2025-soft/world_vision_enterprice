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
        Schema::create('inv_customer_advances', function (Blueprint $table) {
            $table->id();
             $table->foreignId('customer_id')->constrained('inv_customers')->onDelete('cascade');
            $table->decimal('advance_amount', 15, 2)->default(0);
            $table->decimal('adjusted_amount', 15, 2)->default(0);
            $table->decimal('remaining_amount', 15, 2)->virtualAs('advance_amount - adjusted_amount');
            $table->date('date');
            $table->string('payment_method')->nullable();
            $table->string('reference_no')->nullable();
            $table->text('note')->nullable();
            $table->enum('type', ['advance', 'adjustment'])->default('advance');
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_customer_advances');
    }
};
