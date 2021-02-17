<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class GroupSubTax extends Model
{
    protected $table = "group_sub_taxes";
    public function tax_rate()
    {
        return $this->belongsTo(\App\TaxRate::class, 'group_tax_id');
    }
}
