<?php

namespace Modules\Inventory\Services\Inventory\Transaction;

class ItemService
{
    /**
     * SAVE ITEMS ONLY (NO BUSINESS LOGIC)
     */
    public function store(object $model, array $items, string $relation): void
    {
        $data = [];

        foreach ($items as $item) {

            $data[] = array_merge($item, [
                $relation => $model->id,
                'branch_id' => $model->branch_id,
            ]);
        }

        $model->items()->createMany($data);
    }

    /**
     * REPLACE ITEMS (UPDATE FLOW)
     */
    public function replace(object $model, array $items, string $relation): void
    {
        $model->items()->delete();

        $this->store($model, $items, $relation);
    }
}