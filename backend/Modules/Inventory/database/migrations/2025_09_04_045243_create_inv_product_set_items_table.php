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
        Schema::create('inv_product_set_items', function (Blueprint $table) {
            $table->id();
             $table->foreignId('product_set_id')->constrained('inv_product_sets')->onDelete('cascade');
            $table->foreignId('product_id')->constrained('inv_products')->onDelete('cascade');
            $table->integer('qty')->default(1);
            $table->decimal('price', 8, 2)->nullable();
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_product_set_items');
    }
};
