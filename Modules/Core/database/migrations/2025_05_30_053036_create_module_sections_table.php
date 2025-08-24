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
        Schema::create('module_sections', function (Blueprint $table) {
            $table->id();
            $table->foreignId('module_id')->constrained('modules')->onDelete('cascade');
            $table->string('section_name');
            $table->string('section_action_route');
            $table->string('section_roles_permission');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('module_sections');
    }
};
