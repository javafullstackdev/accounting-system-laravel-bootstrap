<?php

namespace App\Http\Controllers;

use App\Bank;
use App\PurchaseLine;
use App\Transaction;

use Yajra\DataTables\Facades\DataTables;
use Illuminate\Http\Request;

use App\Utils\Util;
use App\Utils\ModuleUtil;
use App\Utils\ProductUtil;
use App\Utils\TransactionUtil;

use DB;
use Log;

class BankController extends Controller
{
    protected $commonUtil;
    protected $productUtil;
    protected $transactionUtil;
    protected $moduleUtil;

    public function __construct(Util $commonUtil, ModuleUtil $moduleUtil, ProductUtil $productUtil, TransactionUtil $transactionUtil)
    {
        $this->commonUtil = $commonUtil;
        $this->productUtil = $productUtil;
        $this->transactionUtil = $transactionUtil;
        $this->moduleUtil = $moduleUtil;
    }

    public function index()
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            $business_id = request()->session()->get('user.business_id');

            $banks = Bank::where('bank.business_id', $business_id)
                ->LeftJoin('transactions as t', 't.bank_id', '=', 'bank.id')
                ->LeftJoin(
                    'transaction_payments AS tp',
                    't.id',
                    '=',
                    'tp.transaction_id'
                )
                ->select(
                    'name',
                    'bank.id as id',
                    DB::raw('
                        (SUM(IF(t.type = "sell", tp.amount, 0))
                         + SUM(IF(t.type = "purchase", -1*tp.amount, 0))
                         + SUM(IF(t.type = "bank_payment", t.final_total, 0))
                         - SUM(IF(t.type = "expense" and t.payment_status = "paid", t.final_total, 0))
                         + SUM(IF(t.type = "sell_return", -1 * t.final_total, 0))) 
                         as balance
                    ')
                )->groupBy('bank.id');

            return Datatables::of($banks)
                ->editColumn(
                    'Balance',
                    '<span class="display_currency total-paid" data-currency_symbol="true" data-orig-value="{{ $balance }}">
                        $ {{ $balance }}
                    </span>'
                )
                ->addColumn(
                    'action',
                    '
                    <a href="{{action(\'BankController@show\', [$id])}}" class="btn btn-primary btn-xs" aria-hidden="true"><i class="fa fa-eye-slash" aria-hidden="true"></i></a> &nbsp;
                    <button type="button" data-href="{{action(\'BankController@edit\', [$id])}}" class="btn btn-xs btn-primary btn-modal" data-container=".bank_edit_modal"><i class="glyphicon glyphicon-edit"></i> @lang("messages.edit")</button>
                    <a data-href="{{action(\'BankController@destroy\', [$id])}}" class="btn btn-danger btn-xs delete_bank"><i class="glyphicon glyphicon-trash"></i> @lang("messages.delete")</a>
                    '
                )
                ->removeColumn('id')
                ->rawColumns([1, 2])
                ->make(false);
        }

        return view('bank.index');
    }

    public function create()
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }
//        $business_id = request()->session()->get('user.business_id');

        return view('bank.create');
    }

    public function store(Request $request)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $business_id = $request->session()->get('user.business_id');

            $input = $request->only(['name']);
            $input['business_id'] = $business_id;

            $bank = Bank::create($input);

            $output = ['success' => true,
                'msg' => __("bank.bank_added_success")
            ];
        } catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());

            $output = ['success' => false,
                'msg' => __("messages.something_went_wrong")
            ];
        }

        return $output;
    }

    public function show(Request $request, $id)
    {
        if (!auth()->user()->can('inventory.view')) {
            abort(403, 'Unauthorized action.');
        }

        $bank = Bank::findOrFail($id);
        $bank_name = $bank->name;
        $bank_id = $id;

        if ($request->ajax()) {
            $business_id = $request->session()->get('user.business_id');

            $bankDetails = Transaction::LeftJoin('bank', 'transactions.bank_id', '=', 'bank.id')
                ->LeftJoin('contacts as c', 'c.id', '=', 'transactions.contact_id')
                ->LeftJoin(
                    'transaction_payments AS tp',
                    'transactions.id',
                    '=',
                    'tp.transaction_id'
                )
                ->select(
                    'transactions.transaction_date as date',
                    'transactions.type as type',
                    'invoice_no',
                    'ref_no',
                    'c.name',
                    DB::raw('
                        (CASE
                            WHEN transactions.type = "purchase" OR transactions.type = "sell" THEN sum(tp.amount)
                            WHEN transactions.type = "bank_payment" OR transactions.type = "sell_return" OR transactions.type = "expense" THEN transactions.final_total
                            ELSE 0
                        END) as total_paid
                    ')
                )
                ->where('transactions.bank_id', '=', $bank_id)
                ->where('transactions.business_id', '=', $business_id)
                ->where(function($q) {
                    $q->where('transactions.payment_status', '=', null)
                        ->orWhere('transactions.payment_status', '!=', 'due');
                })
                ->groupBy('transactions.id')->orderBy('date', 'desc');

            return Datatables::of($bankDetails)
                ->editColumn('date', '{{@format_date($date)}}')
                ->editColumn(
                    'type',
                    '
                    <span>
                        @if($type == "purchase")
                            PURCHASE
                        @elseif($type == "sell")
                            SELL
                        @elseif($type == "sell_return")
                            SELL RETURN
                        @elseif($type == "bank_payment")
                            MANUAL PAYMENT
                        @elseif($type == "expense")
                            EXPENSE
                        @endif
                    </span>
                    '
                )
                ->editColumn(
                    'invoice_no',
                    '<span class="">
                        @if ($type == "purchase" || $type == "expense")
                            {{ $ref_no }}
                        @elseif ($type == "sell" || $type == "sell_return")
                            {{ $invoice_no }}
                        @endif
                    </span>'
                )
                ->removeColumn('ref_no')
                ->editColumn(
                    'total_paid',
                    '<span class="display_currency total-paid" data-currency_symbol="true" data-orig-value="{{ $total_paid }}">
                        @if($type == "sell_return" || $type == "expense")
                            $ {{ -$total_paid }}
                        @else 
                            $ {{ $total_paid }}
                        @endif
                    </span>'
                )
                ->rawColumns([0, 1, 2, 4])
                ->make(false);
        }

        return view('bank.show')->with(compact('bank_name', 'bank_id'));
    }

    public function edit($id)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        $business_id = request()->session()->get('user.business_id');
        $bank = Bank::where('business_id', $business_id)->find($id);

        return view('bank.edit')->with(compact('bank'));
    }

    public function update(Request $request, $id)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $input = $request->only(['name']);

            $business_id = $request->session()->get('user.business_id');

            Bank::where('business_id', $business_id)
                ->where('id', $id)
                ->update($input);

            $output = ['success' => true,
                'msg' => __('bank.bank_updated_success')
            ];
        } catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());

            $output = ['success' => false,
                'msg' => __("messages.something_went_wrong")
            ];
        }

        return $output;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\StoreFront  $storeFront
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if (!auth()->user()->can('supplier.delete') && !auth()->user()->can('customer.delete')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            try {
                $business_id = request()->session()->get('user.business_id');

                //Check if any transaction related to this contact exists
                $count = Transaction::where('business_id', $business_id)
                    ->where('bank_id', $id)
                    ->count();
                if ($count == 0) {
                    $bank = Bank::where('business_id', $business_id)->findOrFail($id);
                    $bank->delete();
                    $output = ['success' => true,
                        'msg' => __("bank.deleted_success")
                    ];
                } else {
                    $output = ['success' => false,
                        'msg' => __("lang_v1.you_cannot_delete_this_contact")
                    ];
                }
            } catch (\Exception $e) {
                \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());

                $output = ['success' => false,
                    'msg' => __("messages.something_went_wrong")
                ];
            }

            return $output;
        }
    }


    /**
     * Checks if the given location id already exist for the current business.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
//    public function checkLocationId(Request $request)
//    {
//        $city = $request->input('city');
//
//        $valid = 'true';
//        if (!empty($city)) {
//            $business_id = $request->session()->get('user.business_id');
//
//            $query = BusinessLocation::where('business_id', $business_id)
//                ->where('city', $city);
//            $count = $query->count();
//            if ($count > 0) {
//                $valid = 'false';
//            }
//        }
//        echo $valid;
//        exit;
//    }
}
