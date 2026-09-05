<?php 
return [
    'name'          => 'Supplier Previous Due',
    'entry_type'    => 'Supplier Previous Due',
    'module_key'    => 'inventory',
    'feature'       => 'supplier_previous_due',
    'components'    => [
        [
            'key'           => 'previous_due',    
            'name'          => 'Previous Due',    
            'description'   => 'Supplier opening due.',         
            'is_debit'      => true
        ],
        [
            'key'           => 'opening_balance', 
            'name'          => 'Opening Balance', 
            'description'   => 'Opening balance adjustment.',   
            'is_debit'      => false
        ]
    ]
];