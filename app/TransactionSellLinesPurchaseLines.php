<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TransactionSellLinesPurchaseLines extends Model
{
    protected $table = "transaction_sell_lines_purchase_lines";
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
     */
    protected $guarded = ['id'];
}
