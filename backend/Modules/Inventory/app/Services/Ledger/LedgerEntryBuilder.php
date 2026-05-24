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

        if (!empty($data['due'])) {
            $entries[] = $this->makeEntry(
                $this->type,
                $data['due'],
                'in'
            );
        }

        if (!empty($data['advance_adjust'])) {
            $entries[] = $this->makeEntry(
                'advance_adjust',
                $data['advance_adjust'],
                'out'
            );
        }

        if (!empty($data['payment'])) {
            $entries[] = $this->makeEntry(
                'payment',
                $data['payment'],
                'out'
            );
        }

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
        // dd( $cashRefundAmount);

        if ($adjustDueAmount > 0) {
            $entries[] = $this->makeEntry(
                'return_due_adjust',
                $adjustDueAmount,
                'out'
            );
        }

        if ($cashRefundAmount > 0) {
            $entries[] = $this->makeEntry(
                'return_cash_refund',
                $cashRefundAmount,
                'out'
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
}