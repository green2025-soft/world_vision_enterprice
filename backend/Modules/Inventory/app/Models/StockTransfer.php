<?php

namespace Modules\Inventory\Models;

use Modules\Core\Models\Branch;
use Modules\Core\Models\User;
class StockTransfer extends InvBaseModel
{
    protected $fillable = ['transfer_no', 'from_branch_id', 'to_branch_id', 'transfer_date', 'total_amount', 'note', 'created_by', 'status'];

    protected $casts = [
        'transfer_date' => 'date',
        'total_amount' => 'decimal:2',
    ];

    protected array $searchable = ['transfer_no'];

     public function fromBranch(){
        return $this->belongsTo(Branch::class, 'from_branch_id');
    }

     public function toBranch(){
        return $this->belongsTo(Branch::class, 'to_branch_id');
    }

    
    public function user(){
        return $this->belongsTo(User::class, 'created_by');
    }

    public function items()
    {
        return $this->hasMany(StockTransferItem::class, 'stock_transfer_id');
    }

    
}
