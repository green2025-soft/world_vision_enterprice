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
        Schema::create('inv_products', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('sku')->unique();
            $table->foreignId('category_id')->nullable()->constrained('inv_categories')->onDelete('set null');
            $table->foreignId('unit_id')->nullable()->constrained('inv_units')->onDelete('set null');
            $table->foreignId('brand_id')->nullable()->constrained('inv_brands')->onDelete('set null');
            $table->decimal('purchase_price', 12, 2)->default(0)->nullable();
            $table->decimal('selling_price', 12, 2)->default(0)->nullable();
            $table->integer('stock_quantity')->default(0);
            $table->boolean('status')->default(1);
            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->integer('re_order')->nullable();
            $table->string('made_by')->nullable();
            $table->string('image')->nullable();
             $table->text('specification')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_products');
    }
};
