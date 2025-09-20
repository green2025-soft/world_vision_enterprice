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
        Schema::create('acc_module_entries', function (Blueprint $table) {
            $table->id();
            $table->string('module_name')->comment('Module name like sales, purchase, etc.');
            $table->string('entry_type')->comment('Entry type like invoice, bill, etc.');
            $table->string('description')->nullable();
            $table->boolean('status')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('acc_module_entries');
    }
};
