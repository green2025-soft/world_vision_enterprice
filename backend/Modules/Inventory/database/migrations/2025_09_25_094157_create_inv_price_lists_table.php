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
        Schema::create('inv_price_lists', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_id')->constrained('inv_products')->cascadeOnDelete();
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->string('price_type')->default('retail');
            $table->decimal('price', 12, 2);
            $table->date('start_date')->nullable();
            $table->date('end_date')->nullable(); 
            $table->text('remarks')->nullable();
            $table->timestamps();
            $table->unique(['product_id', 'branch_id', 'price_type'], 'unique_price_list');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_price_lists');
    }
};
