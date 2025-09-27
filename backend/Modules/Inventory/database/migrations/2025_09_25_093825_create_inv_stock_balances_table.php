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
        Schema::create('inv_stock_balances', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_id')->constrained('inv_products')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->integer('current_stock')->default(0);
            $table->timestamps();
            $table->unique(['product_id', 'branch_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_stock_balances');
    }
};
