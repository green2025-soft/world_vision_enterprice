<?php

namespace Modules\Accounting\Models;

use Modules\Core\Models\User;

class AuditLog extends AccBaseModel
{
     const UPDATED_AT = null;
    protected $fillable = [
        'user_id', 'action','source_ref', 'details'
    ];

    protected $casts = [
        'details' => 'array',
    ];


    
    public function user(): BelongsTo{
        return $this->belongsTo(User::class, 'user_id');
    }

    public static function record($action, $details = null, $sourceRef=null, $userId = null)
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
            'source_ref'    => $sourceRef,
        ]);
    }






}
