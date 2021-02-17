<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class RegularBalance extends Model
{
    protected $table = "regular_balances";

    protected $guarded = ['id'];
}