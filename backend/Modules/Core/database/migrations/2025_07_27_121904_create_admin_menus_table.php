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
        Schema::create('admin_menus', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->unsignedBigInteger('module_id');
            $table->string('route')->nullable();
            $table->string('icon')->nullable();
            $table->unsignedBigInteger('parent_id')->nullable();
            $table->integer('sequence')->default(0);
            $table->string('permission_route')->nullable();
            $table->boolean('status')->default(true);
            $table->timestamps();

             $table->foreign('parent_id')->references('id')->on('admin_menus')->onDelete('cascade');
              $table->foreign('module_id')
                  ->references('id')
                  ->on('modules')
                  ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('admin_menus');
    }
};
