<?php

namespace Modules\Inventory\Services\Ledger;

class LedgerEntryBuilder
{
    protected array $data = [];

    protected string $type = '';

    /**
     * Set payload
     */
    protected function set(array $data, string $type): void
    {
        $this->data = $data;
        $this->type = $type;
    }

    /**
     * Create ledger entry
     */
    protected function makeEntry(
        string $type,
        float|int $amount,
        string $direction
    ): array {
        unset($this->data['items']);
        unset($this->data['date']);
        return array_merge($this->data, [
            'type'      => $type,
            'amount'    => $amount,
            'direction' => $direction,
        ]);
    }

    /**
     * SALE / PURCHASE BUILDER
     */
    public function build(array $data, string $type): array
    {
        $this->set($data, $type);

        $entries = [];

        if (!empty($data['subtotal'])) {
            $entries[] = $this->makeEntry(
                $this->type,
                $data['subtotal'],
                'out'
            );
        }

        if (!empty($data['tax_amount'])) {
            $entries[] = $this->makeEntry(
                'tex_amount',
                $data['tax_amount'],
                'out'
            );
        }

        if (!empty($data['advance_adjust'])) {
            $entries[] = $this->makeEntry(
                'advance_adjust',
                $data['advance_adjust'],
                'in'
            );
        }

        if (!empty($data['paid_amount'])) {
            $entries[] = $this->makeEntry(
                'payment',
                $data['paid_amount'],
                'in'
            );
        }

        if (!empty($data['adjustment'])) {
            $adjustment = $data['adjustment'] + $data['discount_amount'];
            $entries[] = $this->makeEntry(
                'adjustment',
                $adjustment,
                'in'
            );
        }
        // \Log::debug( $entries);exit();

        return $entries;
    }

    /**
     * 🔥 RETURN BUILDER
     */
    public function buildReturn(array $data, string $type): array
    {
        $this->set($data, $type);

        $entries = [];

        $refundAmount     = (float) ($data['advance'] ?? 0);
        $adjustDueAmount  = (float) ($data['due_adjusted'] ?? 0);
        $cashRefundAmount = (float) ($data['cash_return'] ?? 0);
        $totalRefund      = (float) ($data['total_refund_amount'] ?? 0);
        // dd( $cashRefundAmount);

        if ($adjustDueAmount > 0) {
            $entries[] = $this->makeEntry(
                'return_due_adjust',
                $adjustDueAmount,
                'in'
            );
        }

        if ($cashRefundAmount > 0) {
            $entries[] = $this->makeEntry(
                'return_cash_refund',
                $cashRefundAmount,
                'in'
            );
        }

        // $remaining = $refundAmount - ($adjustDueAmount + $cashRefundAmount);

        if ($refundAmount > 0) {
            $entries[] = $this->makeEntry(
                'return_advance',
                $refundAmount,
                'in'
            );
        }

        return $entries;
    }

    public function buildPayment(array $data, string $type){
        $this->set($data, $type);
        $entries = [];
        $adjustment     = (float) ($data['adjustment'] ?? 0);
        $payment        = (float) ($data['payment'] ?? 0);

         if ($payment > 0) {
            $entries[] = $this->makeEntry(
                'due_payment',
                $payment,
                'in'
            );
        }

        if ($adjustment > 0) {
            $entries[] = $this->makeEntry(
                'due_payment_adjust',
                $adjustment,
                'in'
            );
        }

        return $entries;
    }
}