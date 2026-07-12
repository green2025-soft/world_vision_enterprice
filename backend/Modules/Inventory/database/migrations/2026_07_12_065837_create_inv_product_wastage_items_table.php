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
        Schema::create('inv_product_wastage_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_wastage_id')->constrained('inv_product_wastages')->onDelete('cascade');
            $table->foreignId('product_id')->constrained('inv_products')->onDelete('restrict');
            $table->decimal('quantity', 12, 2)->default(0);
            $table->decimal('unit_cost', 12, 4)->default(0);
            $table->decimal('total_cost', 12, 4)->default(0);
            $table->string('reason')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_product_wastage_items');
    }
};
