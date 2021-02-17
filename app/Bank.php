<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Bank extends Model
{
    //
    protected $guarded = ['id'];
    protected $table = "bank";

	public static function forDropdown($business_id, $show_all = false, $receipt_printer_type_attribute = false)
	{
		$query = Bank::where('business_id', $business_id);

		$banks = $query->pluck('name', 'id');

		if ($show_all) {
			$banks->prepend(__('report.all_banks'), '');
		}

		return $banks;
	}
}
