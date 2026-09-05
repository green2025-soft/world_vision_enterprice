<?php


namespace Modules\Inventory\Services\DueAdvance;

use Modules\Inventory\Models\Customer;

class CustomerPreviousDueService extends BaseDueAdvanceService
{
    protected string $type             = 'customer_previous_due';

    protected string $referencePrefix   = 'CPD-';
    protected string $referenceKey      = 'id';

    protected function modelClass(): string
    {
        return Customer::class;
    }

    protected function prepareData(array $data): array
    {
        return $data;
    }

    protected function prepareAccountingData(array $data,$model): array {
        $data['customer_id']    = $model->id;
        $data['amount']         = $model->previous_due;
        $data['opening_balance']= $model->previous_due;
        return $data;
    }

   
}
