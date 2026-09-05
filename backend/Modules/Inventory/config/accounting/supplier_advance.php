<?php 
return [
    'name'          => 'Supplier Advance',
    'entry_type'    => 'Supplier Advance',
    'module_key'    => 'inventory',
    'feature'       => 'supplier_advance',
    'components'    => [
        [
            'key'           => 'amount',             
            'name'          => 'Cash',             
            'description'   => 'Advance paid to supplier.',   
            'is_debit'      => true
        ],
        [
            'key'           => 'supplier_advance', 
            'name'          => 'Supplier Advance', 
            'description'   => 'Supplier advance asset.',     
            'is_debit'      => false
        ]
    ]
];