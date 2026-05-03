<?php

namespace Modules\Inventory\Core\Stock;

use Illuminate\Support\Facades\DB;

class StockReconciler
{
    public function __construct(
        private StockEngine $engine,
        private StockReverseService $reverse
    ) {}

    public function reprocess(string $type, $source, array $oldItems, array $newItems): void
    {
        DB::transaction(function () use ($type, $source, $oldItems, $newItems) {

            // 1. reverse old stock
            $this->engine->process(
                $this->reverse->reverseType($type),
                $source,
                $oldItems
            );

            // 2. apply new stock
            $this->engine->process(
                $type,
                $source,
                $newItems
            );
        });
    }
}