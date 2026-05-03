<?php 

namespace Modules\Inventory\DTO;

class ReturnDTO
{
    public function __construct(
        public int $reference_id,
        public string $type, // sale_return | purchase_return
        public array $items,
        public int $branch_id
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            reference_id: $data['reference_id'],
            type: $data['type'],
            items: array_map(fn($item) => StockItemDTO::fromArray($item), $data['items']),
            branch_id: $data['branch_id'],
        );
    }
}