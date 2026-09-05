<?php 
return [
    'name'          => 'Customer Due Payment',
    'entry_type'    => 'Customer Payment Voucher',
    'module_key'    => 'inventory',
    'feature'       => 'customer_due_payment',
    'components'    => [
        [
            'key'           => 'payment',      
            'name'          => 'Payment',      
            'description'   => 'Customer due payment.',   
            'is_debit'      => true
        ],
        [
            'key'           => 'adjustment',   
            'name'          => 'Adjustment',   
            'description'   => 'Payment adjustment.',     
            'is_debit'      => true
        ],
        [
            'key'           => 'total_amount', 
            'name'          => 'Total Amount', 
            'description'   => 'Total settled amount.',   
            'is_debit'      => false
        ],
    ],
];