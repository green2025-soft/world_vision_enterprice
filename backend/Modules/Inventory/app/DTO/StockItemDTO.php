<?php 

namespace Modules\Inventory\DTO;

class StockItemDTO
{
    public function __construct(
        public int $product_id,
        public float $quantity,
        public float $unit_price = 0,
        public float $sale_price = 0,
        public float $discount = 0,
        public float $tax = 0
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            product_id: $data['product_id'],
            quantity: $data['quantity'],
            unit_price: $data['unit_price'] ?? 0,
            sale_price: $data['sale_price'] ?? 0,
            discount: $data['discount'] ?? 0,
            tax: $data['tax'] ?? 0,
        );
    }
}