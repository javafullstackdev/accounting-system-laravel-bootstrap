<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class InvoiceScheme extends Model
{
    protected $table = "invoice_schemes";
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
     */
    protected $guarded = ['id'];
}
