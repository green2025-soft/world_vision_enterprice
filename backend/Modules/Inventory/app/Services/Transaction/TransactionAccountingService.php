<?php

namespace Modules\Inventory\Services\Transaction;

use Modules\Inventory\Services\Resolver\AccountingServiceResolver;

 class TransactionAccountingService
{
    protected $accounting;

    public function __construct(
        protected AccountingServiceResolver $resolver
    ) {}



    public function record(
        object $model,
        array $data,
        array $totals,
        array $context,
        bool $isUpdate = false
    ): void {

     $accounting = $this->resolver->resolve($context['type']);

        if ($isUpdate) {
            $this->delete($model->id, $context['type']);
        }

       $accounting->recordTransaction([

            'amount'      => $totals['net_total'] ?? 0,
            'paid_amount' => $totals['paid_amount'] ?? 0,
            'due_amount'  => $totals['due_amount'] ?? 0,

            'tax_amount'      => $totals['total_tax_amount'] ?? 0,
            'discount_amount'  => $totals['total_discount_amount'] ?? 0,

            'inventory' => $totals['inventory_subtotal'] ?? 0,
            'cogs'      => $totals['inventory_subtotal'] ?? 0,

            'date'         => $data['date'] ?? now(),
            'reference_id' => $model->id,
            'reference_no' => $model->invoice_no ?? null,
            'note'         => $data['note'] ?? null,
            'branch_id'    => $data['branch_id'] ?? null,

            // 🔥 NEW IMPORTANT PART
            ...($context['extra'] ?? []),
        ], $context['type']);
    }

    public function delete(int $id, string $type): void
    {
        $accounting = $this->resolver->resolve($type);
        $accounting->deleteEntry($id, $type);
    }
}