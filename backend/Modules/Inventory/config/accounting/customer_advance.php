<?php
return [
   'name'       => 'Customer Advance',
   'entry_type' => 'Customer Advance',
   'module_key' => 'inventory',
   'feature'    => 'customer_advance',
   'components' => [
        [
            'key'           => 'amount',   
            'name'          => 'Cash',
            'description'   => 'Advance received from customer.',
            'is_debit'      => true
        ],
        [
            'key'           => 'customer_advance', 
            'name'          => 'Customer Advance', 
            'description'   => 'Customer advance liability.',         
            'is_debit'      => false
        ]
    ]
];