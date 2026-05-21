<?php

namespace Modules\Inventory\Services\Ledger;

class LedgerEntryBuilder
{
    /**
     * SALE / PURCHASE BUILDER
     */
    public function build(array $data, string $type): array
    {
        $entries = [];

        /**
         * 1️⃣ MAIN DUE ENTRY
         */
        if (!empty($data['due'])) {
            $entries[] = [
                'type'      => $type, // sale OR purchase
                'amount'    => $data['due'],
                'direction' => 'in',
            ];
        }

        /**
         * 2️⃣ ADVANCE ADJUST (COMMON)
         */
        if (!empty($data['advance_adjust'])) {
            $entries[] = [
                'type'      => 'advance_adjust',
                'amount'    => $data['advance_adjust'],
                'direction' => 'out',
            ];
        }

        /**
         * 3️⃣ PAYMENT (COMMON)
         */
        if (!empty($data['payment'])) {
            $entries[] = [
                'type'      => 'payment',
                'amount'    => $data['payment'],
                'direction' => 'out',
            ];
        }

        return $entries;
    }

    /**
     * 🔥 RETURN BUILDER (REVERSAL LOGIC)
     */
    public function buildReturn(array $data, string $type): array
    {
        $entries = [];

        /**
         * INPUT (already normalized outside)
         */
        $refundAmount     = (float) ($data['advance'] ?? 0);
        $adjustDueAmount  = (float) ($data['adjusted_due_amount'] ?? 0);
        $cashRefundAmount = (float) ($data['cash_refund_amount'] ?? 0);

        /**
         * 1️⃣ DUE ADJUST (highest priority)
         * Liability reduction
         */
        if ($adjustDueAmount > 0) {
            $entries[] = [
                'type'      => 'return_due_adjust',
                'amount'    => $adjustDueAmount,
                'direction' => 'out',
            ];
        }

        /**
         * 2️⃣ CASH REFUND
         * Money going out
         */
        if ($cashRefundAmount > 0) {
            $entries[] = [
                'type'      => 'return_cash_refund',
                'amount'    => $cashRefundAmount,
                'direction' => 'out',
            ];
        }

        /**
         * 3️⃣ ADVANCE (remaining balance)
         * Future credit to customer/supplier
         */
        $remaining = $refundAmount - ($adjustDueAmount + $cashRefundAmount);

        if ($remaining > 0) {
            $entries[] = [
                'type'      => 'return_advance',
                'amount'    => $remaining,
                'direction' => 'in',
            ];
        }

        return $entries;
    }
}