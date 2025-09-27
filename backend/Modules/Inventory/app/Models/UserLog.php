<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
use Modules\Core\Models\User;
class UserLog extends InvBaseModel
{
    const UPDATED_AT = null;
    protected $fillable = ['user_id', 'action', 'module', 'reference_id', 'old_data', 'new_data', 'branch_id'];

    
      public function user(){
        return $this->belongsTo(User::class, 'user_id');
    }

     public function branch(){
        return $this->belongsTo(Branch::class, 'branch_id');
    }

     public static function record($action, $details = null, $referenceId =null, $oldData = null, $newData = null, $branchId = null, $userId = null)
    {
        
        if ($details instanceof \Illuminate\Database\Eloquent\Model) {
            $details = $details->toArray();
        }


        if (is_array($details)) {
            array_walk_recursive($details, function (&$value) {
                if ($value instanceof \Illuminate\Database\Eloquent\Model) {
                    $value = $value->toArray();
                }
            });
        }

        return self::create([
            'user_id'       => $userId ?? auth()->id(),
            'action'        => $action,
            'details'       => $details,
            'reference_id'  => $referenceId,
            'old_data'      => $oldData ? json_encode($oldData) : null,
            'new_data'      => $newData ? json_encode($newData) : null,
            'branch_id'     => $branchId,
        ]);
    }
}
