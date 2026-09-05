<?php 
return [
    'name'          => 'Sales Voucher',
    'entry_type'    => 'Sales Voucher',
    'module_key'    => 'inventory',
    'feature'       => 'sale',
    'components'    => [
        [
            'key'           => 'paid_amount',      
            'name'          => 'Paid Amount',      
            'description'   => 'Amount paid by customer.',        
            'is_debit'      => true
        ],

        
        // [
        //     'key'           => 'cogs',             
        //     'name'          => 'Cost of Goods Sold',
        //     'description'   => 'Cost of sold goods.',            
        //     'is_debit'      => true
        // ],
        [
            'key'           => 'customer_advance', 
            'name'          => 'Customer Advance', 
            'description'   => 'Customer advance adjustment.',    
            'is_debit'      => true
        ],
        [
            'key'           => 'due_amount',       
            'name'          => 'Due Amount',       
            'description'   => 'Customer outstanding due.',       
            'is_debit'      => true
        ],
        [
            'key'           => 'discount_amount',  
            'name'          => 'Discount Amount',  
            'description'   => 'Customer discount.',              
            'is_debit'      => true
        ],
        [
            'key'           => 'adjustment',       
            'name'          => 'Adjustment',       
            'description'   => 'Rounding or other adjustment.',   
            'is_debit'      => true
        ],
        // [
        //     'key'           => 'inventory',        
        //     'name'          => 'Inventory',        
        //     'description'   => 'Inventory value reduction.',      
        //     'is_debit'      => false
        // ],
        [
            'key'           => 'sales_amount',    
            'name'          => 'Sales Amount',    
            'description'   => 'Sales Amount.',                  
            'is_debit'      => false
        ],
        [
            'key'           => 'tax_amount',       
            'name'          => 'Tax Amount',       
            'description'   => 'Sales tax or VAT.',               
            'is_debit'      => false
        ],
        
    ]
];