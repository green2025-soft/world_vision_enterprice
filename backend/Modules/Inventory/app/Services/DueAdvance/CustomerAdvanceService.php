<?php


namespace Modules\Inventory\Services\DueAdvance;


use Modules\Inventory\Models\CustomerAdvance;

class CustomerAdvanceService extends BaseDueAdvanceService
{
    protected string $type             = 'customer_advance';

    protected string $referencePrefix   = 'CAV-';


    protected function modelClass(): string
    {
        return CustomerAdvance::class;
    }

    protected function prepareData(array $data): array
    {
        return $data;
    }

    protected function prepareAccountingData(array $data,$model): array {
        $data['customer_id']    = $model->id;
        $data['amount']         = $model->advance_amount;
        $data['customer_advance']= $model->advance_amount;
        return $data;
    }

   
}
