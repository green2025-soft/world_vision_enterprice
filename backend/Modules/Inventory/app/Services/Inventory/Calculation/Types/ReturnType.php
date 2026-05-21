<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types;

use Modules\Inventory\Services\Inventory\Calculation\Resolvers\FinancialResolver;

abstract class ReturnType extends BaseType {


    public function __construct(
        protected FinancialResolver $financial,
    ) {}
    protected function trade(
        array $item,
        array $input,
        float $ratio = 1
    ): array
    {

        $price  = $item['return_unit_price'];
        $qty    = $item['return_qty'];

        $subtotal = $qty * $price;
       // ---------------- COST + INVENTORY ----------------
        $costPrice = $this->financial->resolveCost($item)*$ratio;
        
        return [
            'product_id'            => $item['product_id'],
            'return_qty'            => $qty,
            'wastage_qty'           => $item['wastage_qty']??'',
            'return_unit_price'     => $item['return_unit_price']??'',
            'total_return_price'    => $subtotal,
            'cost_price'            => $costPrice,
            'return_date'           => $input['return_date'] ?? now(),
        ];
    }

}