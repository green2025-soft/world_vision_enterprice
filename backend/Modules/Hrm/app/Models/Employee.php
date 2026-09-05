<?php

namespace Modules\Hrm\Models;

// use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Str;

class Employee extends HrmBaseModel
{
    // use SoftDeletes;

    protected $fillable = [
        'employee_id',
        'first_name',
        'last_name',
        'father_name',
        'mother_name',
        'spouse_name',
        'slug',
        'email',
        'phone',
        'present_address',
        'permanent_address',
        'city',
        'state',
        'country',
        'postal_code',
        'department_id',
        'designation_id',
        'branch_id',
        'gender_id',
        'religion_id',
        'nationality',
        'marital_status',
        'date_of_birth',
        'joining_date',
        'confirmation_date',
        'termination_date',
        'shift_id',
        'probation_period',
        'tin_no',
        'national_id',
        'passport_number',
        'passport_expiry_date',
        'employee_category_id',
        'employee_type_id',
        'employee_status_id',
        'blood_group_id',
        'profile_picture',
        'remarks',
        'created_by',
        'updated_by',
    ];

    protected array $searchable = [
        'employee_id',
        'first_name',
        'last_name',
        'email',
        'phone',
        'national_id',
        'passport_number',
    ];

    protected $casts = [
        'date_of_birth' => 'date',
        'joining_date' => 'date',
        'confirmation_date' => 'date',
        'termination_date' => 'date',
        'passport_expiry_date' => 'date',
        'created_at' => 'datetime',
        'updated_at' => 'datetime'
    ];

    protected $appends = [
        'full_name',
    ];

    // ✅ ADD THIS ACCESSOR METHOD
    public function getFullNameAttribute(): string
    {
        return $this->first_name . ' ' . $this->last_name;
    }

    public static function generateEmployeeId(): string
    {
        $prefix = 'EMP';
        $year = date('Y');
        $month = date('m');
        
        $lastEmployee = static::whereYear('created_at', $year)
            ->whereMonth('created_at', $month)
            ->latest('id')
            ->first();
        
        if ($lastEmployee && preg_match('/EMP-' . $year . $month . '(\d{4})/', $lastEmployee->employee_id, $matches)) {
            $sequence = intval($matches[1]) + 1;
        } else {
            $sequence = 1;
        }
        
        return $prefix . '-' . $year . $month . str_pad($sequence, 4, '0', STR_PAD_LEFT);
    }
    

    public function department()
    {
        return $this->belongsTo(Department::class, 'department_id');
    }

    /**
     * Get the designation that the employee belongs to
     */
    public function designation()
    {
        return $this->belongsTo(Designation::class, 'designation_id');
    }

    /**
     * Get the gender that the employee belongs to
     */
    public function gender()
    {
        return $this->belongsTo(Gender::class, 'gender_id');
    }

    /**
     * Get the religion that the employee belongs to
     */
    public function religion()
    {
        return $this->belongsTo(Religion::class, 'religion_id');
    }

    /**
     * Get the shift that the employee belongs to
     */
    public function shift()
    {
        return $this->belongsTo(Shift::class, 'shift_id');
    }

    /**
     * Get the employee category that the employee belongs to
     */
    public function employeeCategory()
    {
        return $this->belongsTo(EmployeeCategory::class, 'employee_category_id');
    }

    /**
     * Get the employee type that the employee belongs to
     */
    public function employeeType()
    {
        return $this->belongsTo(EmployeeType::class, 'employee_type_id');
    }

    /**
     * Get the employee status that the employee belongs to
     */
    public function employeeStatus()
    {
        return $this->belongsTo(EmployeeStatus::class, 'employee_status_id');
    }

    /**
     * Get the blood group that the employee belongs to
     */
    public function bloodGroup()
    {
        return $this->belongsTo(BloodGroup::class, 'blood_group_id');
    }


    protected static function booted(): void
    {
        static::creating(function ($employee) {
            if (empty($employee->employee_id)) {
                $employee->employee_id = static::generateEmployeeId();
            }
        });

        static::creating(function ($employee) {
            if (empty($employee->slug)) {
                $employee->slug = Str::slug($employee->first_name . ' ' . $employee->last_name);
            }
        });

        static::updating(function ($employee) {
            if ($employee->isDirty('first_name') || $employee->isDirty('last_name')) {
                $employee->slug = Str::slug($employee->first_name . ' ' . $employee->last_name);
            }
        });

        // ❌ FIX THIS: The variable name is wrong here
        static::updating(function ($employee) {
            if ($employee->isDirty('first_name') || $employee->isDirty('last_name')) {
                $employee->slug = Str::slug($employee->first_name . ' ' . $employee->last_name);
            }
        });
    }
}