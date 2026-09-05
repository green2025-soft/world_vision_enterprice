<?php
return [
    'name'          => 'Customer Previous Due',
    'entry_type'    => 'Customer Previous Due',
    'module_key'    => 'inventory',
    'feature'       => 'customer_previous_due',
    'components'    => [
        [
            'key'           => 'previous_due',    
            'name'          => 'Previous Due',    
            'description'   => 'Customer opening due.',         
            'is_debit'      => true
        ],
        [
            'key'           => 'opening_balance', 
            'name'          => 'Opening Balance', 
            'description'   => 'Opening balance adjustment.',   
            'is_debit'      => false
        ],
    ],
    
];