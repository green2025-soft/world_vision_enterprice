<?php

namespace Modules\Core\Models;

use Illuminate\Database\Eloquent\Model;

use Modules\Core\Traits\HandlesModelQueries;

class BaseModel extends Model
{
    use  HandlesModelQueries;
}
