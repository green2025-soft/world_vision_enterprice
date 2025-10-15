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
        Schema::create('inv_stock_movements', function (Blueprint $table) {
            $table->id();
            $table->foreignId('product_id')->constrained('inv_products')->cascadeOnDelete();
            $table->enum('movement_type', [
                'purchase',
                'sale',
                'transfer_in',
                'transfer_out',
                'damage',
                'purchase_return',
                'sale_return',
                'adjustment_in',
                'adjustment_out'
            ]);

            $table->integer('quantity');
            $table->float('consumed_quantity')->nullable()->default(0)->after('quantity');
            $table->decimal('unit_price', 10, 2);
            $table->decimal('sales_price', 10, 2)->nullable();

            $table->unsignedBigInteger('reference_id')->nullable();

            $table->foreignId('branch_id')->constrained('branches')->onDelete('cascade');
            $table->enum('strategy',['fifo', 'lifo'])->default('fifo');
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inv_stock_movements');
    }
};
