<?php 
return [
    'name'          => 'Sale Return',
    'entry_type'    => 'Return Voucher',
    'module_key'    => 'inventory',
    'feature'       => 'sale_return',
    'components'    => [
        [
            'key'           => 'sales_return',      
            'name'          => 'Sales Return',      
            'description'   => 'Sales return amount.',          
            'is_debit'      => true
        ],
        [
            'key'           => 'sales_adjustment',  
            'name'          => 'Sales Adjustment',  
            'description'   => 'Sales return adjustment.',      
            'is_debit'      => true
        ],
        [
            'key'           => 'inventory',         
            'name'          => 'Inventory',         
            'description'   => 'Returned inventory value.',     
            'is_debit'      => true
        ],
        [
            'key'           => 'stock_wastage',     
            'name'          => 'Stock Wastage',     
            'description'   => 'Damaged returned stock.',       
            'is_debit'      => true
        ],
        [
            'key'           => 'due_adjusted',      
            'name'          => 'Due Adjusted',      
            'description'   => 'Customer due adjustment.',      
            'is_debit'      => false
        ],
        [
            'key'           => 'cash_return',       
            'name'          => 'Cash Return',       
            'description'   => 'Cash refunded to customer.',    
            'is_debit'      => false
        ],
        [
            'key'           => 'customer_advance',  
            'name'          => 'Customer Advance',  
            'description'   => 'Customer advance adjustment.',  
            'is_debit'      => false
        ],
        [
            'key'           => 'returned_stock',    
            'name'          => 'Returned Stock',    
            'description'   => 'Returned stock cost.',          
            'is_debit'      => false
        ],
        [
            'key'           => 'inventory_wastage', 
            'name'          => 'Inventory Wastage', 
            'description'   => 'Returned stock wastage.',       
            'is_debit'      => false
        ],
    ]
];