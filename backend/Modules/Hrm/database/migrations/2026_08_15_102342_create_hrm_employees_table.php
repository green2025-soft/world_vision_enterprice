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
        Schema::create('hrm_employees', function (Blueprint $table) {
            $table->id();
            
            $table->string('employee_id')->unique()->comment('Unique employee ID');
            $table->string('first_name');
            $table->string('last_name');
            $table->string('father_name')->nullable();
            $table->string('mother_name')->nullable();
            $table->string('spouse_name')->nullable();
            $table->string('slug')->nullable();
            $table->string('email')->nullable()->unique();
            $table->string('phone')->nullable()->unique();
            $table->text('present_address')->nullable();
            $table->text('permanent_address')->nullable();
            $table->string('city')->nullable();
            $table->string('state')->nullable();
            $table->string('country')->nullable();
            $table->string('postal_code')->nullable();

            $table->foreignId('department_id')->nullable()->constrained('hrm_departments')->nullOnDelete();
            $table->foreignId('designation_id')->nullable()->constrained('hrm_designations')->nullOnDelete();
            $table->foreignId('branch_id')->nullable()->constrained('branches')->nullOnDelete();

            $table->foreignId('gender_id')->nullable()->constrained('hrm_genders')->nullOnDelete();
            $table->foreignId('religion_id')->nullable()->constrained('hrm_religions')->nullOnDelete();

            $table->string('nationality')->nullable()->default('Bangladeshi');
            $table->enum('marital_status', ['Married', 'Unmarried', 'Divorced', 'Widowed'])->nullable();
            
            $table->date('date_of_birth')->nullable();
            $table->date('joining_date')->nullable();
            $table->date('confirmation_date')->nullable();
            $table->date('termination_date')->nullable();

            $table->foreignId('shift_id')->nullable()->constrained('hrm_shifts')->nullOnDelete();
            $table->string('probation_period')->nullable()->comment('In months');
            
            $table->string('tin_no')->nullable()->comment('Tax identification number');
            $table->string('national_id')->nullable()->unique();
            $table->string('passport_number')->nullable()->unique();
            $table->date('passport_expiry_date')->nullable();
            
            $table->foreignId('employee_category_id')->nullable()->constrained('hrm_employee_categories')->nullOnDelete();
            $table->foreignId('employee_type_id')->nullable()->constrained('hrm_employee_types')->nullOnDelete();
            $table->foreignId('employee_status_id')->nullable()->constrained('hrm_employee_statuses')->nullOnDelete();
            $table->foreignId('blood_group_id')->nullable()->constrained('hrm_blood_groups')->nullOnDelete();

            $table->string('profile_picture')->nullable();
            $table->text('remarks')->nullable();
            
            $table->foreignId('created_by')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('updated_by')->nullable()->constrained('users')->nullOnDelete();
            
            // Indexes
            $table->index('employee_id');
            $table->index(['first_name', 'last_name']);
            $table->index(['email', 'phone']);
            
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('hrm_employees');
    }
};