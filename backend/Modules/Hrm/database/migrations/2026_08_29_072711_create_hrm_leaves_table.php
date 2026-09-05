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
        Schema::create('hrm_leaves', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('employee_id');
            $table->unsignedInteger('department_id');
            $table->unsignedInteger('designation_id');
            $table->unsignedInteger('leave_category_id');
            
            $table->date('application_date');
            $table->date('leave_from')->nullable();
            $table->date('leave_to')->nullable();
            $table->decimal('total_leave', 4, 2)->nullable();
            $table->decimal('leave_limit', 4, 2)->nullable();
            $table->decimal('previous_taken', 4, 2)->nullable();
            $table->decimal('leave_balance', 4, 2)->nullable();

            $table->text('leave_reason')->nullable();
            $table->string('attachment')->nullable();

            $table->date('accepted_date')->nullable();
            $table->tinyInteger('accepted_by')->default(false);
            $table->date('forwared_date')->nullable();
            $table->tinyInteger('forwared_by')->default(false);
            $table->date('approved_date')->nullable();
            $table->tinyInteger('approved_by')->default(false);

            $table->string('status')->default('false');
            $table->text('remarks')->nullable();

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('hrm_leaves');
    }
};
