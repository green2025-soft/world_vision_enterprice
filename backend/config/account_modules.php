<?php

return [

    'modules' => [

        'sale' => [
            'name' => 'Sales Voucher',
            'entry_type' => 'Sales Voucher',

            'components' => [
                [
                    'key' => 'paid_amount',
                    'name' => 'Paid Amount',
                    'description' => 'Cash or bank amount received immediately from the customer.',
                ],
                [
                    'key' => 'sales_revenue',
                    'name' => 'Sales Revenue',
                    'description' => 'Revenue generated from the sale of products or services.',
                ],
                [
                    'key' => 'discount_amount',
                    'name' => 'Discount Amount',
                    'description' => 'Discount allowed to the customer on the sales transaction.',
                ],
                [
                    'key' => 'cogs',
                    'name' => 'Cost of Goods Sold',
                    'description' => 'Cost of inventory sold to the customer.',
                ],
                [
                    'key' => 'inventory',
                    'name' => 'Inventory',
                    'description' => 'Reduces inventory value when products are sold.',
                ],
                [
                    'key' => 'customer_advance',
                    'name' => 'Customer Advance',
                    'description' => 'Amount adjusted against an advance previously received from the customer.',
                ],
                [
                    'key' => 'due_amount',
                    'name' => 'Due Amount',
                    'description' => 'Amount remaining receivable from the customer.',
                ],
                [
                    'key' => 'tax_amount',
                    'name' => 'Tax Amount',
                    'description' => 'Sales tax or VAT collected from the customer.',
                ],
                [
                    'key' => 'adjustment',
                    'name' => 'Adjustment',
                    'description' => 'Rounding or other sales adjustment amount.',
                ],
            ],
        ],

        'purchase' => [
            'name' => 'Purchase Voucher',
            'entry_type' => 'Purchase Voucher',

            'components' => [
                [
                    'key' => 'inventory',
                    'name' => 'Inventory',
                    'description' => 'Increases inventory value when products are purchased.',
                ],
                [
                    'key' => 'tax_amount',
                    'name' => 'Tax Amount',
                    'description' => 'Purchase tax or input VAT paid on the purchase.',
                ],
                [
                    'key' => 'discount_amount',
                    'name' => 'Discount Amount',
                    'description' => 'Discount received from the supplier on the purchase.',
                ],
                [
                    'key' => 'paid_amount',
                    'name' => 'Paid Amount',
                    'description' => 'Cash or bank amount paid immediately to the supplier.',
                ],
                [
                    'key' => 'supplier_advance',
                    'name' => 'Supplier Advance',
                    'description' => 'Amount adjusted against an advance previously paid to the supplier.',
                ],
                [
                    'key' => 'due_amount',
                    'name' => 'Due Amount',
                    'description' => 'Amount remaining payable to the supplier.',
                ],
                [
                    'key' => 'adjustment',
                    'name' => 'Adjustment',
                    'description' => 'Rounding or other purchase adjustment amount.',
                ],
            ],
        ],

        'sale_return' => [
            'name' => 'Sale Return',
            'entry_type' => 'Return Voucher',

            'components' => [
                [
                    'key' => 'sales_return',
                    'name' => 'Sales Return',
                    'description' => 'Reverses sales revenue for products returned by the customer.',
                ],
                [
                    'key' => 'sales_adjustment',
                    'name' => 'Sales Adjustment',
                    'description' => 'Handles price or rounding adjustments related to the sales return.',
                ],
                [
                    'key' => 'inventory',
                    'name' => 'Inventory',
                    'description' => 'Adds returned products back into inventory.',
                ],
                [
                    'key' => 'stock_wastage',
                    'name' => 'Stock Wastage',
                    'description' => 'Records returned stock that is damaged or cannot be added to inventory.',
                ],
                [
                    'key' => 'due_adjusted',
                    'name' => 'Due Adjusted',
                    'description' => 'Adjusts the customer receivable balance for the returned amount.',
                ],
                [
                    'key' => 'cash_return',
                    'name' => 'Cash Return',
                    'description' => 'Cash or bank amount refunded to the customer.',
                ],
                [
                    'key' => 'customer_advance',
                    'name' => 'Customer Advance',
                    'description' => 'Adjusts the customer advance balance against the returned amount.',
                ],
                [
                    'key' => 'returned_stock',
                    'name' => 'Returned Stock',
                    'description' => 'Records the cost value of stock physically returned by the customer.',
                ],
                [
                    'key' => 'inventory_wastage',
                    'name' => 'Inventory Wastage',
                    'description' => 'Reduces inventory value for returned stock that is treated as wastage.',
                ],
            ],
        ],

        'purchase_return' => [
            'name' => 'Purchase Return',
            'entry_type' => 'Purchase Return Voucher',

            'components' => [
                [
                    'key' => 'cash_return',
                    'name' => 'Cash Return',
                    'description' => 'Cash or bank amount received back from the supplier.',
                ],
                [
                    'key' => 'supplier_advance',
                    'name' => 'Supplier Advance',
                    'description' => 'Adjusts the supplier advance balance against the returned purchase.',
                ],
                [
                    'key' => 'due_adjusted',
                    'name' => 'Due Adjusted',
                    'description' => 'Reduces the amount payable to the supplier.',
                ],
                [
                    'key' => 'returned_stock',
                    'name' => 'Returned Stock',
                    'description' => 'Records the cost value of products returned to the supplier.',
                ],
                [
                    'key' => 'stock_wastage',
                    'name' => 'Stock Wastage',
                    'description' => 'Records stock-related loss or wastage during purchase return.',
                ],
                [
                    'key' => 'inventory_shrinkage_loss',
                    'name' => 'Inventory Shrinkage Loss',
                    'description' => 'Records loss caused by inventory quantity or value differences.',
                ],
                [
                    'key' => 'inventory',
                    'name' => 'Inventory',
                    'description' => 'Reduces inventory value when products are returned to the supplier.',
                ],
                [
                    'key' => 'purchase_return',
                    'name' => 'Purchase Return',
                    'description' => 'Records the financial effect of goods returned to the supplier.',
                ],
                [
                    'key' => 'purchase_adjustment',
                    'name' => 'Purchase Adjustment',
                    'description' => 'Handles purchase price, rounding, or other return adjustments.',
                ],
            ],
        ],

        'customer_advance' => [
            'name' => 'Customer Advance',
            'entry_type' => 'Customer Advance',

            'components' => [
                [
                    'key' => 'cash',
                    'name' => 'Cash',
                    'description' => 'Cash or bank amount received from the customer as an advance.',
                ],
                [
                    'key' => 'customer_advance',
                    'name' => 'Customer Advance',
                    'description' => 'Liability created for advance money received from the customer.',
                ],
            ],
        ],

        'supplier_advance' => [
            'name' => 'Supplier Advance',
            'entry_type' => 'Supplier Advance',

            'components' => [
                [
                    'key' => 'cash',
                    'name' => 'Cash',
                    'description' => 'Cash or bank amount paid to the supplier as an advance.',
                ],
                [
                    'key' => 'supplier_advance',
                    'name' => 'Supplier Advance',
                    'description' => 'Asset created for advance money paid to the supplier.',
                ],
            ],
        ],

        'customer_previous_due' => [
            'name' => 'Customer Previous Due',
            'entry_type' => 'Customer Previous Due',

            'components' => [
                [
                    'key' => 'previous_due',
                    'name' => 'Previous Due',
                    'description' => 'Opening receivable balance previously due from the customer.',
                ],
                [
                    'key' => 'opening_balance',
                    'name' => 'Opening Balance',
                    'description' => 'Equity adjustment used to establish the opening customer balance.',
                ],
            ],
        ],

        'supplier_previous_due' => [
            'name' => 'Supplier Previous Due',
            'entry_type' => 'Supplier Previous Due',

            'components' => [
                [
                    'key' => 'previous_due',
                    'name' => 'Previous Due',
                    'description' => 'Opening payable balance previously due to the supplier.',
                ],
                [
                    'key' => 'opening_balance',
                    'name' => 'Opening Balance',
                    'description' => 'Equity adjustment used to establish the opening supplier balance.',
                ],
            ],
        ],

        'customer_due_payment' => [
            'name' => 'Customer Due Payment',
            'entry_type' => 'Customer Payment Voucher',

            'components' => [
                [
                    'key' => 'payment',
                    'name' => 'Payment',
                    'description' => 'Cash or bank amount received from the customer against an outstanding due.',
                ],
                [
                    'key' => 'adjustment',
                    'name' => 'Adjustment',
                    'description' => 'Discount, rounding, or other adjustment applied during customer payment.',
                ],
                [
                    'key' => 'total_amount',
                    'name' => 'Total Amount',
                    'description' => 'Total customer due amount settled by the payment and adjustment.',
                ],
            ],
        ],

        'supplier_due_payment' => [
            'name' => 'Supplier Due Payment',
            'entry_type' => 'Supplier Payment Voucher',

            'components' => [
                [
                    'key' => 'total_amount',
                    'name' => 'Total Amount',
                    'description' => 'Total supplier payable amount settled by the payment and adjustment.',
                ],
                [
                    'key' => 'adjustment',
                    'name' => 'Adjustment',
                    'description' => 'Discount, rounding, or other adjustment applied during supplier payment.',
                ],
                [
                    'key' => 'payment',
                    'name' => 'Payment',
                    'description' => 'Cash or bank amount paid to the supplier against an outstanding due.',
                ],
            ],
        ],

        'stock_transfer' => [
            'name' => 'Stock Transfer Voucher',
            'entry_type' => 'stock_transfer',

            'components' => [
                [
                    'key' => 'inventory_transfer_in',
                    'name' => 'Inventory Transfer In',
                    'description' => 'Inventory value received at the destination branch or warehouse.',
                ],
                [
                    'key' => 'git_transfer_out',
                    'name' => 'Goods in Transit Transfer Out',
                    'description' => 'Records goods transferred out and placed in transit.',
                ],
                [
                    'key' => 'inventory_transfer_out',
                    'name' => 'Inventory Transfer Out',
                    'description' => 'Reduces inventory value at the source branch or warehouse.',
                ],
                [
                    'key' => 'git_transfer_in',
                    'name' => 'Goods in Transit Transfer In',
                    'description' => 'Clears goods in transit when transferred stock reaches the destination.',
                ],
            ],
        ],

        'product_wastage' => [
            'name' => 'Product Wastage Voucher',
            'entry_type' => 'Product Wastage',

            'components' => [
                [
                    'key' => 'stock_wastage',
                    'name' => 'Stock Wastage',
                    'description' => 'Expense account used to record damaged, expired, or lost stock.',
                ],
                [
                    'key' => 'inventory_wastage',
                    'name' => 'Inventory Wastage',
                    'description' => 'Reduces inventory value for damaged, expired, or lost products.',
                ],
            ],
        ],

    ],
];
