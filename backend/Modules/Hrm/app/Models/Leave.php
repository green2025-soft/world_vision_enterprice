<?php

namespace Modules\Hrm\Models;

use Modules\Hrm\Models\LeaveDetails;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo; // Import BelongsTo namespace
use Carbon\Carbon;
use Carbon\CarbonPeriod;

class Leave extends HrmBaseModel
{
    // Eager load details alongside employee, department, and designation by default
    protected $with = ['details', 'employee', 'department', 'designation'];
    
    protected $fillable = [
        'employee_id',
        'department_id',
        'designation_id',
        'leave_category_id',
        'application_date',
        'leave_from',
        'leave_to',
        'total_leave',
        'leave_limit',
        'previous_taken',
        'leave_balance',
        'leave_reason',
        'attachment',
        'accepted_date',
        'accepted_by',
        'forwared_date',
        'forwared_by',
        'approved_date',
        'approved_by',
        'status',
        'remarks',
    ];

    protected array $searchable = [
        'employee_id',
        'department_id',
        'designation_id',
        'leave_category_id',
        'application_date',
        'leave_from',
        'leave_to',
        'total_leave',
        'leave_limit',
    ];

    protected static function booted(): void
    {
        static::creating(function (Leave $leave) {
            $from = Carbon::parse($leave->leave_from);
            $to = Carbon::parse($leave->leave_to);
            $leave->total_leave = $from->diffInDays($to) + 1;

            if ($leave->leave_category_id) {
                $category = \Modules\Hrm\Models\LeaveCategory::find($leave->leave_category_id);
                $leave->leave_limit = $category ? $category->leave_limit : 0; 
            }

            $leave->previous_taken = LeaveDetails::where('employee_id', $leave->employee_id)
                ->where('leave_category_id', $leave->leave_category_id)
                ->where('status', 'approved')
                ->count();

            $leave->leave_balance = $leave->leave_limit - ($leave->previous_taken + $leave->total_leave);
        });

        static::created(function (Leave $leave) {
            $period = CarbonPeriod::create($leave->leave_from, $leave->leave_to);

            foreach ($period as $date) {
                $leave->details()->create([
                    'employee_id'       => $leave->employee_id,
                    'department_id'     => $leave->department_id,
                    'designation_id'    => $leave->designation_id,
                    'leave_category_id' => $leave->leave_category_id,
                    'application_date'  => $leave->application_date ?? now()->format('Y-m-d'),
                    'leave_date'        => $date->format('Y-m-d'),
                    'status'            => $leave->status ?? 'pending',
                ]);
            }
        });

        static::updating(function (Leave $leave) {
            if ($leave->isDirty(['leave_from', 'leave_to', 'status'])) {
                $from = Carbon::parse($leave->leave_from);
                $to = Carbon::parse($leave->leave_to);
                $leave->total_leave = $from->diffInDays($to) + 1;

                $leave->leave_balance = $leave->leave_limit - ($leave->previous_taken + $leave->total_leave);

                if ($leave->isDirty(['leave_from', 'leave_to'])) {
                    $leave->details()->delete();
                    
                    $period = CarbonPeriod::create($leave->leave_from, $leave->leave_to);
                    foreach ($period as $date) {
                        $leave->details()->create([
                            'employee_id'       => $leave->employee_id,
                            'department_id'     => $leave->department_id,
                            'designation_id'    => $leave->designation_id,
                            'leave_category_id' => $leave->leave_category_id,
                            'application_date'  => $leave->application_date ?? now()->format('Y-m-d'),
                            'leave_date'        => $date->format('Y-m-d'),
                            'status'            => $leave->status ?? 'pending',
                        ]);
                    }
                } else if ($leave->isDirty('status')) {
                    $leave->details()->update(['status' => $leave->status]);
                }
            }
        });
    }

    /**
     * Relationship with LeaveDetails
     */
    public function details(): HasMany
    {
        return $this->hasMany(LeaveDetails::class, 'leave_id');
    }

        /**
     * Relationship with Employee
     */
    public function employee(): BelongsTo
    {
        return $this->belongsTo(Employee::class, 'employee_id')
            ->select(['id', 'first_name', 'last_name']);
    }

    /**
     * Relationship with Department
     */
    public function department(): BelongsTo
    {
        return $this->belongsTo(Department::class, 'department_id')
                    ->select(['id', 'name', 'short_name']);
    }

    /**
     * Relationship with Designation
     */
    public function designation(): BelongsTo
    {
        return $this->belongsTo(Designation::class, 'designation_id')
                    ->select(['id', 'name', 'short_name']);
    }

}
