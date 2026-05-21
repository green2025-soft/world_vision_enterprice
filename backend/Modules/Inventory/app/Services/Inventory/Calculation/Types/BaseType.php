<?php 


namespace Modules\Inventory\Services\Inventory\Calculation\Types;

abstract class BaseType
{
    protected function base(array $item, array $input): array
    {
        return [
            'product_id' => $item['product_id'],
            'branch_id'  => $input['branch_id'] ?? null,
        ];
    }

    abstract public function build(
        array $item,
        array $input,
        float $ratio = 1
    ): array;
}