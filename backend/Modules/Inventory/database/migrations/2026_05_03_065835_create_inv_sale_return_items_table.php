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
        Schema::create('inv_sale_return_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('sale_return_id')->constrained('inv_sale_returns')->onDelete('cascade');
            $table->foreignId('sale_item_id')->constrained('inv_sale_items')->onDelete('cascade');
            $table->foreignId('product_id')->constrained('inv_products')->onDelete('restrict');
            $table->decimal('sold_qty', 12, 2);  
            $table->decimal('return_qty', 12, 2);
            $table->decimal('unit_price', 15, 2)->default(0);
            $table->decimal('return_unit_price', 12, 2);
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_sale_return_items');
    }
};
