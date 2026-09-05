<?php


namespace Modules\Inventory\Services\DueAdvance;


use Modules\Inventory\Models\Supplier;

class SupplierPreviousDueService extends BaseDueAdvanceService
{
    protected string $type             = 'supplier_previous_due';

    protected string $referencePrefix   = 'SPD-';
    protected string $referenceKey      = 'id';

    protected function modelClass(): string
    {
        return Supplier::class;
    }

    protected function prepareData(array $data): array
    {
        return $data;
    }

    protected function prepareAccountingData(array $data,$model): array {
        $data['supplier_id']    = $model->id;
        $data['amount']         = $model->previous_due;
        $data['opening_balance']= $model->previous_due;
        return $data;
    }

   
}
