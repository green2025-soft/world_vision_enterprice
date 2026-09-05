<?php 
return [
    'name'          => 'Purchase Return',
    'entry_type'    => 'Purchase Return Voucher',
    'module_key'    => 'inventory',
    'feature'       => 'purchase_return',
    'components'    => [
        [
            'key'           => 'cash_return',              
            'name'          => 'Cash Return',              
            'description'   => 'Cash received from supplier.',    
            'is_debit'      => true
        ],
        [
            'key'           => 'supplier_advance',         
            'name'          => 'Supplier Advance',         
            'description'   => 'Supplier advance adjustment.' ,   
            'is_debit'      => true
        ],
        [
            'key'           => 'due_adjusted',             
            'name'          => 'Due Adjusted',             
            'description'   => 'Supplier due adjustment.' ,       
            'is_debit'      => true
        ],
        [
            'key'           => 'returned_stock',           
            'name'          => 'Returned Stock',           
            'description'   => 'Returned stock cost.',            
            'is_debit'      => true
        ],
        [
            'key'           => 'stock_wastage',            
            'name'          => 'Stock Wastage',            
            'description'   => 'Returned stock wastage.',         
            'is_debit'      => true
        ],
        [
            'key'           => 'inventory_shrinkage_loss', 
            'name'          => 'Inventory Shrinkage Loss', 
            'description'   => 'Inventory value loss.',           
            'is_debit'      => true
        ],
        [
            'key'           => 'inventory',                
            'name'          => 'Inventory',                
            'description'   => 'Inventory value reduction.',      
            'is_debit'      => false
        ],
        [
            'key'           => 'purchase_return',          
            'name'          => 'Purchase Return',          
            'description'   => 'Purchase return amount.',         
            'is_debit'      => false
        ],
        [
            'key'           => 'purchase_adjustment',      
            'name'          => 'Purchase Adjustment',      
            'description'   => 'Purchase return adjustment.',     
            'is_debit'      => false
        ],
    ],
];