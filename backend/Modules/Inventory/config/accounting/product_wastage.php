<?php 
return [

    'name'          => 'Product Wastage Voucher',
    'entry_type'    => 'Product Wastage',
    'module_key'    => 'inventory',
    'feature'       => 'product_wastage',
    'components'    => [
        [
            'key'           => 'stock_wastage',     
            'name'          => 'Stock Wastage',     
            'description'   => 'Stock wastage expense.',        
            'is_debit'      => true
        ],
        [
            'key'           => 'inventory_wastage', 
            'name'          => 'Inventory Wastage', 
            'description'   => 'Inventory value reduction.',    
            'is_debit'      => false
        ]
    ] 
];