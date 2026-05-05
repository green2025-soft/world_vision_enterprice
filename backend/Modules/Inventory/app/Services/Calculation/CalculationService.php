<?php

namespace Modules\Inventory\Services\Calculation;

class CalculationService
{
    public function __construct(
        protected ItemCalculator $itemCalculator,
        protected TotalCalculator $totalCalculator
    ) {}

    public function calculate(array $items, array $input, string $type): array
    {
        $totalAmount = (float) ($input['total_amount'] ?? 0);
        $netTotal    = (float) ($input['net_total'] ?? 0);
         $ratio = $totalAmount > 0
        ? ($netTotal / $totalAmount)
        : 1;
        $calculatedItems = $this->itemCalculator->calculate(
            $items,
            $input,
            $type,
            $ratio
        );

        $totals = $this->totalCalculator->calculate(
            $calculatedItems,
            $input
        );

        return [
            'items'  => $calculatedItems,
            'totals' => $totals,
        ];
    }
}