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
        Schema::create('inv_purchase_return_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('purchase_return_id')->constrained('inv_purchase_returns')->onDelete('cascade');
            $table->foreignId('purchase_item_id')->constrained('inv_purchase_items')->onDelete('cascade');
            $table->foreignId('product_id')->constrained('inv_products')->onDelete('restrict');
            $table->decimal('return_qty', 12, 2)->default(0);
            $table->decimal('wastage_qty', 12, 2)->default(0);
            $table->decimal('unit_purchase_price', 12, 2)->default(0);
            $table->decimal('return_unit_price', 12, 2)->default(0);
            $table->decimal('total_return_price', 12, 2)->default(0);
            $table->decimal('total_refund_price', 12, 2)->default(0);
            $table->decimal('cost_price', 12, 2)->default(0);
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
