<?php


namespace Modules\Inventory\Services\DueAdvance;


use Modules\Inventory\Models\SupplierAdvance;

class SupplierAdvanceService extends BaseDueAdvanceService
{
    protected string $type             = 'supplier_advance';

    protected string $referencePrefix   = 'SAV-';


    protected function modelClass(): string
    {
        return SupplierAdvance::class;
    }

    protected function prepareData(array $data): array
    {
        return $data;
    }

    protected function prepareAccountingData(array $data,$model): array {
        $data['supplier_id']    = $model->id;
        $data['amount']         = $model->advance_amount;
        $data['supplier_advance']= $model->advance_amount;
        return $data;
    }

   
}
