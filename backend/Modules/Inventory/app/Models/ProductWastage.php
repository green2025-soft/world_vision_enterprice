<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\User;
class ProductWastage extends InvBaseModel
{
    protected $fillable = ['wastage_no', 'wastage_date', 'total_amount', 'note', 'branch_id', 'created_by'];

    protected $casts = [
        'wastage_date' => 'date',
        'total_amount' => 'decimal:2',
    ];

    protected array $searchable = ['wastage_no'];

    
    public function user(){
        return $this->belongsTo(User::class, 'created_by');
    }

    public function items()
    {
        return $this->hasMany(ProductWastageItem::class, 'product_wastage_id');
    }

    
}
