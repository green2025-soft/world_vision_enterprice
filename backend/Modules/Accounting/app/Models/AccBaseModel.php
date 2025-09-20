<?php

namespace Modules\Accounting\Models;

use Modules\Core\Models\BaseModel;
use Illuminate\Support\Str;
class AccBaseModel extends BaseModel
{

     protected $tablePrefix = 'acc_';

       public function getTable()
    {
        if (!isset($this->table)) {
            // auto-generate table name from model class name
            $className = class_basename($this); 
            $snakeName = Str::snake(Str::pluralStudly($className)); 
            return $this->tablePrefix . $snakeName; 
        }

        return $this->table;
    }
    
}
