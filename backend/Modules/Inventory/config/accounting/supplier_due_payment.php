<?php 
return [
    'name'          => 'Supplier Due Payment',
    'entry_type'    => 'Supplier Payment Voucher',
    'module_key'    => 'inventory',
    'feature'       => 'supplier_due_payment',
    'components'    => [
        [
            'key'           => 'total_amount', 
            'name'          => 'Total Amount', 
            'description'   => 'Total settled amount.',   
            'is_debit'      => true
        ],
        [
            'key'           => 'adjustment',   
            'name'          => 'Adjustment',   
            'description'   => 'Payment adjustment.',     
            'is_debit'      => false
        ],
        [
            'key'           => 'payment',      
            'name'          => 'Payment',      
            'description'   => 'Supplier due payment.',   
            'is_debit'      => false
        ]
    ]   
];