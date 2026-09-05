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
        Schema::create('hrm_leave_details', function (Blueprint $table) {
            $table->id();

            $table->unsignedBigInteger('leave_id');
            $table->unsignedBigInteger('employee_id');
            $table->unsignedInteger('department_id');
            $table->unsignedInteger('designation_id');
            $table->unsignedInteger('leave_category_id');
            
            $table->date('application_date');
            $table->date('leave_date');
            
            $table->string('status')->default('false');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('hrm_leave_details');
    }
};
