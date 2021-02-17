<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ReferenceCount extends Model
{
    protected $table = "reference_counts";
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
     */
    protected $guarded = ['id'];
}
