<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
use Modules\Core\Models\User;
class Payment extends InvBaseModel
{
    protected $fillable = ['payment_type', 'reference_type', 'reference_id', 'amount', 'payment_method', 'payment_date', 'note', 'branch_id', 'created_by'];


    public function user(){
        return $this->belongsTo(User::class, 'created_by');
    }


    public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }

    
}
