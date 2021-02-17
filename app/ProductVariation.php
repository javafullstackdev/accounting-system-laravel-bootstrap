<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class ProductVariation extends Model
{
    protected $table = "product_variations";
    /**
     * The attributes that aren't mass assignable.
     *
     * @var array
     */
    protected $guarded = ['id'];
    
    public function variations()
    {
        return $this->hasMany(\App\Variation::class);
    }
}
