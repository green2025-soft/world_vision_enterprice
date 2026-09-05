<?php
return [
    'inventory' => [
        'sale' => [
            'name' => 'Sales Voucher',
            'entry_type' => 'Sales Voucher',
            'components' => [
                ['key' => 'paid_amount',      'name' => 'Paid Amount',      'description' => 'Amount paid by customer.',        'is_debit'=> true],
                ['key' => 'sales_revenue',    'name' => 'Sales Revenue',    'description' => 'Sales revenue.',                  'is_debit'=> false],
                ['key' => 'discount_amount',  'name' => 'Discount Amount',  'description' => 'Customer discount.',              'is_debit'=> true],
                ['key' => 'cogs',             'name' => 'Cost of Goods Sold','description' => 'Cost of sold goods.',            'is_debit'=> true],
                ['key' => 'inventory',        'name' => 'Inventory',        'description' => 'Inventory value reduction.',      'is_debit'=> false],
                ['key' => 'customer_advance', 'name' => 'Customer Advance', 'description' => 'Customer advance adjustment.',    'is_debit'=> true],
                ['key' => 'due_amount',       'name' => 'Due Amount',       'description' => 'Customer outstanding due.',       'is_debit'=> true],
                ['key' => 'tax_amount',       'name' => 'Tax Amount',       'description' => 'Sales tax or VAT.',               'is_debit'=> false],
                ['key' => 'adjustment',       'name' => 'Adjustment',       'description' => 'Rounding or other adjustment.',   'is_debit'=> false],
            ],
        ],

        'purchase' => [
            'name' => 'Purchase Voucher',
            'entry_type' => 'Purchase Voucher',
            'components' => [
                ['key' => 'inventory',        'name' => 'Inventory',        'description' => 'Inventory value increase.',       'is_debit'=> true],
                ['key' => 'tax_amount',       'name' => 'Tax Amount',       'description' => 'Purchase tax or VAT.',            'is_debit'=> true],
                ['key' => 'discount_amount',  'name' => 'Discount Amount',  'description' => 'Supplier discount.',              'is_debit'=> false],
                ['key' => 'paid_amount',      'name' => 'Paid Amount',      'description' => 'Amount paid to supplier.',        'is_debit'=> false],
                ['key' => 'supplier_advance', 'name' => 'Supplier Advance', 'description' => 'Supplier advance adjustment.',    'is_debit'=> false],
                ['key' => 'due_amount',       'name' => 'Due Amount',       'description' => 'Supplier outstanding due.'],      'is_debit'=> false,
                ['key' => 'adjustment',       'name' => 'Adjustment',       'description' => 'Rounding or other adjustment.',   'is_debit'=> true],
            ],
        ],

        'sale_return' => [
            'name' => 'Sale Return',
            'entry_type' => 'Return Voucher',
            'components' => [
                ['key' => 'sales_return',      'name' => 'Sales Return',      'description' => 'Sales return amount.',          'is_debit'=> true],
                ['key' => 'sales_adjustment',  'name' => 'Sales Adjustment',  'description' => 'Sales return adjustment.',      'is_debit'=> true],
                ['key' => 'inventory',         'name' => 'Inventory',         'description' => 'Returned inventory value.',     'is_debit'=> true],
                ['key' => 'stock_wastage',     'name' => 'Stock Wastage',     'description' => 'Damaged returned stock.',       'is_debit'=> true],
                ['key' => 'due_adjusted',      'name' => 'Due Adjusted',      'description' => 'Customer due adjustment.',      'is_debit'=> false],
                ['key' => 'cash_return',       'name' => 'Cash Return',       'description' => 'Cash refunded to customer.',    'is_debit'=> false],
                ['key' => 'customer_advance',  'name' => 'Customer Advance',  'description' => 'Customer advance adjustment.',  'is_debit'=> false],
                ['key' => 'returned_stock',    'name' => 'Returned Stock',    'description' => 'Returned stock cost.',          'is_debit'=> false],
                ['key' => 'inventory_wastage', 'name' => 'Inventory Wastage', 'description' => 'Returned stock wastage.',       'is_debit'=> false],
            ],
        ],

        'purchase_return' => [
            'name' => 'Purchase Return',
            'entry_type' => 'Purchase Return Voucher',
            'components' => [
                ['key' => 'cash_return',              'name' => 'Cash Return',              'description' => 'Cash received from supplier.',    'is_debit'=>true],
                ['key' => 'supplier_advance',         'name' => 'Supplier Advance',         'description' => 'Supplier advance adjustment.' ,   'is_debit'=>true],
                ['key' => 'due_adjusted',             'name' => 'Due Adjusted',             'description' => 'Supplier due adjustment.' ,       'is_debit'=>true],
                ['key' => 'returned_stock',           'name' => 'Returned Stock',           'description' => 'Returned stock cost.',            'is_debit'=>true],
                ['key' => 'stock_wastage',            'name' => 'Stock Wastage',            'description' => 'Returned stock wastage.',         'is_debit'=>true],
                ['key' => 'inventory_shrinkage_loss', 'name' => 'Inventory Shrinkage Loss', 'description' => 'Inventory value loss.',           'is_debit'=>true],
                ['key' => 'inventory',                'name' => 'Inventory',                'description' => 'Inventory value reduction.',      'is_debit'=>false],
                ['key' => 'purchase_return',          'name' => 'Purchase Return',          'description' => 'Purchase return amount.',         'is_debit'=>false],
                ['key' => 'purchase_adjustment',      'name' => 'Purchase Adjustment',      'description' => 'Purchase return adjustment.',     'is_debit'=>false],
            ],
        ],

        'customer_advance' => [
            'name' => 'Customer Advance',
            'entry_type' => 'Customer Advance',
            'components' => [
                ['key' => 'cash',             'name' => 'Cash',             'description' => 'Advance received from customer.',     'is_debit'=>true],
                ['key' => 'customer_advance', 'name' => 'Customer Advance', 'description' => 'Customer advance liability.',         'is_debit'=>false],
            ],
        ],

        'supplier_advance' => [
            'name' => 'Supplier Advance',
            'entry_type' => 'Supplier Advance',
            'components' => [
                ['key' => 'cash',             'name' => 'Cash',             'description' => 'Advance paid to supplier.',   'is_debit'=>true],
                ['key' => 'supplier_advance', 'name' => 'Supplier Advance', 'description' => 'Supplier advance asset.',     'is_debit'=>false],
            ],
        ],

        'customer_previous_due' => [
            'name' => 'Customer Previous Due',
            'entry_type' => 'Customer Previous Due',
            'components' => [
                ['key' => 'previous_due',    'name' => 'Previous Due',    'description' => 'Customer opening due.',         'is_debit'=>true],
                ['key' => 'opening_balance', 'name' => 'Opening Balance', 'description' => 'Opening balance adjustment.',   'is_debit'=>false],
            ],
        ],

        'supplier_previous_due' => [
            'name' => 'Supplier Previous Due',
            'entry_type' => 'Supplier Previous Due',
            'components' => [
                ['key' => 'previous_due',    'name' => 'Previous Due',    'description' => 'Supplier opening due.',         'is_debit'=>true],
                ['key' => 'opening_balance', 'name' => 'Opening Balance', 'description' => 'Opening balance adjustment.',   'is_debit'=>false],
            ],
        ],

        'customer_due_payment' => [
            'name' => 'Customer Due Payment',
            'entry_type' => 'Customer Payment Voucher',
            'components' => [
                ['key' => 'payment',      'name' => 'Payment',      'description' => 'Customer due payment.',   'is_debit'=>true],
                ['key' => 'adjustment',   'name' => 'Adjustment',   'description' => 'Payment adjustment.',     'is_debit'=>true],
                ['key' => 'total_amount', 'name' => 'Total Amount', 'description' => 'Total settled amount.',   'is_debit'=>false],
            ],
        ],

        'supplier_due_payment' => [
            'name' => 'Supplier Due Payment',
            'entry_type' => 'Supplier Payment Voucher',
            'components' => [
                ['key' => 'total_amount', 'name' => 'Total Amount', 'description' => 'Total settled amount.',   'is_debit'=>true],
                ['key' => 'adjustment',   'name' => 'Adjustment',   'description' => 'Payment adjustment.',     'is_debit'=>false],
                ['key' => 'payment',      'name' => 'Payment',      'description' => 'Supplier due payment.',   'is_debit'=>false],
            ],
        ],

        'stock_transfer' => [
            'name' => 'Stock Transfer Voucher',
            'entry_type' => 'stock_transfer',
            'components' => [
                ['key' => 'inventory_transfer_in',  'name' => 'Inventory Transfer In',  'description' => 'Inventory received.' ,            'is_debit'=>true],
                ['key' => 'git_transfer_out',       'name' => 'Goods in Transit Out',   'description' => 'Goods sent in transit.',          'is_debit'=>true],
                ['key' => 'inventory_transfer_out', 'name' => 'Inventory Transfer Out', 'description' => 'Inventory transferred out.',      'is_debit'=>false],
                ['key' => 'git_transfer_in',        'name' => 'Goods in Transit In',    'description' => 'Goods received from transit.',    'is_debit'=>false],
            ],
        ],

        'product_wastage' => [
            'name' => 'Product Wastage Voucher',
            'entry_type' => 'Product Wastage',
            'components' => [
                ['key' => 'stock_wastage',     'name' => 'Stock Wastage',     'description' => 'Stock wastage expense.',        'is_debit'=>true],
                ['key' => 'inventory_wastage', 'name' => 'Inventory Wastage', 'description' => 'Inventory value reduction.',    'is_debit'=>false],
            ],
        ],

    ],
];
