<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class StockAdjustmentLine extends Model
{
    protected $table = "stock_adjustment_lines";
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
     */
    protected $guarded = ['id'];
}
