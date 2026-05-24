<?php

namespace Modules\Inventory\Services\Ledger;

use Modules\Inventory\Models\CustomerLedger;
use Modules\Inventory\Models\SupplierLedger;

class TransactionLedgerService extends BaseLedgerService
{
    protected string $model;
    protected string $key;

    /**
     * CUSTOMER CONTEXT
     */
  public function customer(): static
    {
        $clone = clone $this;

        $clone->model = CustomerLedger::class;
        $clone->key = 'customer_id';

        return $clone;
    }

    /**
     * SUPPLIER CONTEXT
     */
    public function supplier(): static
    {
        $clone = clone $this;

        $clone->model = SupplierLedger::class;
        $clone->key = 'supplier_id';

        return $clone;
    }

    /**
     * STORE (OPTIONAL TYPE HANDLING LAYER)
     */
    public function store(array $data)
    {
         if (isset($data[0])){
            $results = [];
             foreach ($data as $item) {
                $results[] = $this->storeOrUpdate($item);
            }
            return $results;
         }
        return $this->storeOrUpdate($data);
    }


    /**
     * MODEL BINDING
     */
    protected function modelClass(): string
    {
        return $this->model;
    }

    /**
     * KEY BINDING
     */
    protected function relationKey(): string
    {
        return $this->key;
    }

    
}