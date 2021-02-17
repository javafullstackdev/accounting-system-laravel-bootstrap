<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TransactionPayment extends Model
{
    protected $table = "transaction_payments";
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
     */
    protected $guarded = ['id'];
}
