<?php 
return [
    'name'          => 'Stock Transfer Voucher',
    'entry_type'    => 'stock_transfer',
    'module_key'    => 'inventory',
    'feature'       => 'stock_transfer',
    'components'    => [
        [
            'key'           => 'inventory_transfer_in',  
            'name'          => 'Inventory Transfer In',  
            'description'   => 'Inventory received.' ,            
            'is_debit'      => true
        ],
        [
            'key'           => 'git_transfer_out',       
            'name'          => 'Goods in Transit Out',   
            'description'   => 'Goods sent in transit.',          
            'is_debit'      => true
        ],
        [
            'key'           => 'inventory_transfer_out', 
            'name'          => 'Inventory Transfer Out', 
            'description'   => 'Inventory transferred out.',      
            'is_debit'      => false
        ],
        [
            'key'           => 'git_transfer_in',        
            'name'          => 'Goods in Transit In',    
            'description'   => 'Goods received from transit.',    
            'is_debit'      => false
        ]
    ]
];