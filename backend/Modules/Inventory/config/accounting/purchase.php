<?php 
return [
    'name'          => 'Purchase Voucher',
    'entry_type'    => 'Purchase Voucher',
    'module_key'    => 'inventory',
    'feature'       => 'purchase',
    'components'    => [
        [
            'key'           => 'inventory',        
            'name'          => 'Purchase',        
            'description'   => 'Inventory value increase.',       
            'is_debit'      => true
        ],
        [
            'key'           => 'tax_amount',       
            'name'          => 'Tax Amount',       
            'description'   => 'Purchase tax or VAT.',            
            'is_debit'      => true
        ],
        [
            'key'           => 'adjustment',       
            'name'          => 'Adjustment',       
            'description'   => 'Rounding or other adjustment.',   
            'is_debit'      => false
        ],
        [
            'key'           => 'discount_amount',  
            'name'          => 'Discount Amount',  
            'description'   => 'Supplier discount.',              
            'is_debit'      => false
        ],
        [
            'key'           => 'paid_amount',      
            'name'          => 'Paid Amount',      
            'description'   => 'Amount paid to supplier.',        
            'is_debit'      => false
        ],
        [
            'key'           => 'supplier_advance', 
            'name'          => 'Supplier Advance', 
            'description'   => 'Supplier advance adjustment.',    
            'is_debit'      => false
        ],
        [
            'key'           => 'due_amount',       
            'name'          => 'Due Amount',       
            'description'   => 'Supplier outstanding due.',      
            'is_debit'      => false,
        ]
    ]
];