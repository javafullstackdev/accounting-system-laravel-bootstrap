<?php

namespace App\Http\Controllers;

use App\Currency;
use Yajra\DataTables\Facades\DataTables;
use Illuminate\Http\Request;

use DB;
use Log;
class CurrencyController extends Controller
{
    public function __construct() {

    }

    public function index() {
        $currencies = Currency::select(['id', 'currency', 'code', 'symbol', 'country', 'currency_rate'])->groupBy('id')->get();

        if (request()->ajax()) {
            return Datatables::of($currencies)
                ->addColumn(
                    'action',
                    '<div class="btn-group">
                        <button type="button" class="btn btn-info dropdown-toggle btn-xs" 
                            data-toggle="dropdown" aria-expanded="false">' .
                    __("messages.actions") .
                    '<span class="caret"></span><span class="sr-only">Toggle Dropdown
                            </span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-right" role="menu">
                            <li><a href="{{action(\'CurrencyController@edit\', [$id])}}" class="edit_currency_button"><i class="glyphicon glyphicon-edit"></i> @lang("messages.edit")</a></li>
<!--                            <li><a href="{{action(\'CurrencyController@destroy\', [$id])}}" class="delete_currency_button"><i class="glyphicon glyphicon-trash"></i> @lang("messages.delete")</a></li>-->
                    </ul></div>'
                )
                ->rawColumns(['action'])
                ->make(true);
        }

        return view('currency.index')->with(compact('currencies'));
    }

    public function create() {

    }

    public function store(){

    }

    public function edit($id) {
        if (request()->ajax()) {
            $currency = Currency::find($id);
            return view('currency.edit')->with(compact('currency'));
        }
    }

    public function update(Request $request, $id) {
        if (request()->ajax()) {
            try {
                $input = $request->only(['currency_rate']);

                $currency = Currency::findOrFail($id);
                foreach($input as $key => $value) {
                    $currency->$key = $value;
                }
                $currency->save();

                $output = ['success' => true,
                    'msg' => __("currency.updated_success")
                ];
            } catch (\Exception $e) {
                \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());

                $output = ['success' => false,
                    'msg' => __("messages.something_went_wrong")
                ];
            }

            return $output;
        }
    }

    public function destroy($id) {

    }

    public function getCurrencyRate($id) {
        $rate = Currency::findOrFail($id);
        $currency_rate['currency_rate'] = $rate->currency_rate;
        return json_encode($currency_rate);
    }

    public function checkCurrency(Request $request) {
        $rate = $request->input('currency_rate');
        $valid = 'true';
        if (!empty($rate)) {
            if ($rate <= 0.000001) {
                $valid = 'false';
            }
        }
        echo $valid;
        exit;
    }
}
