<?php
namespace Modules\Inventory\Services\Accounts;


use Illuminate\Support\Facades\DB;

use Modules\Inventory\Services\Accounts\Customer\CustomerReturnService;

 class TypeAccountResolver {

    public function resolve(string $type)
    {
        
        return match ($type) {
            'sale_return' => app(CustomerReturnService::class),
            default => throw new \Exception("Invalid type"),
        };
    }


}