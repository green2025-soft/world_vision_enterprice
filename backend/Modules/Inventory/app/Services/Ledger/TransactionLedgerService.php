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
    public function customer(): self
    {
        $this->model = CustomerLedger::class;
        $this->key   = 'customer_id';

        return $this;
    }

    /**
     * SUPPLIER CONTEXT
     */
    public function supplier(): self
    {
        $this->model = SupplierLedger::class;
        $this->key   = 'supplier_id';

        return $this;
    }

    /**
     * STORE (OPTIONAL TYPE HANDLING LAYER)
     */
    public function store(array $data)
    {
        return $this->storeOrUpdate($data);
    }

    /**
     * DELETE LEDGER ENTRY
     */
    public function delete(array $data): void
    {
        $this->delete($data);
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