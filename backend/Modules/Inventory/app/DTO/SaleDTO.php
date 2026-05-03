<?php 

namespace Modules\Inventory\DTO;

class SaleDTO
{
    public function __construct(
        public int $customer_id,
        public string $invoice_date,
        public array $items,
        public float $discount = 0,
        public float $tax = 0,
        public float $paid_amount = 0,
        public int $branch_id
    ) {}

    public static function fromArray(array $data): self
    {
        return new self(
            customer_id: $data['customer_id'],
            invoice_date: $data['invoice_date'],
            items: array_map(fn($item) => StockItemDTO::fromArray($item), $data['items']),
            discount: $data['discount'] ?? 0,
            tax: $data['tax'] ?? 0,
            paid_amount: $data['paid_amount'] ?? 0,
            branch_id: $data['branch_id'],
        );
    }
}