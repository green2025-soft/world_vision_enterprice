<?php

use Illuminate\Support\Str;
return [

    'paths' => ['api/*', 'sanctum/csrf-cookie'],

    'allowed_methods' => ['*'], // HTTP method allow

    'allowed_origins' =>  explode(',', env('CORS_ALLOWED_ORIGINS', '')),

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],  // all header allow

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => true, // cookie/token 
];
