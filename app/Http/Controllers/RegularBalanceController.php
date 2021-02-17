<?php

namespace App\Http\Controllers;

use App\Contact;
use App\CustomerGroup;
use App\Transaction;
use App\RegularBalance;

use App\TransactionPayment;
use Yajra\DataTables\Facades\DataTables;
use Illuminate\Http\Request;

use DB;

use App\Utils\Util;
use App\Utils\ModuleUtil;
use App\Utils\TransactionUtil;
use Log;
class RegularBalanceController extends Controller
{
    protected $commonUtil;
    protected $transactionUtil;

    /**
     * Constructor
     *
     * @param Util $commonUtil
     * @return void
     */
    public function __construct(Util $commonUtil,
                                ModuleUtil $moduleUtil,
                                TransactionUtil $transactionUtil)
    {
        $this->commonUtil = $commonUtil;
        $this->moduleUtil = $moduleUtil;
        $this->transactionUtil = $transactionUtil;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (!auth()->user()->can('customer.view')) {
            abort(403, 'Unauthorized action.');
        }
        $type = request()->get('type');

        $business_id = request()->session()->get('user.business_id');

        if (request()->ajax()) {
            $balances = RegularBalance::leftJoin('contacts AS c', 'regular_balances.contact_id', '=', 'c.id')
                ->where('regular_balances.business_id', $business_id)
                ->select([
                    'regular_balances.id',
                    'c.name as name',
                    'regular_balances.receive_date as date',
                    'regular_balances.amount as amount'
                ]);

            return Datatables::of($balances)
                ->editColumn(
                    'amount',
                    '<span class="display_currency" data-currency_symbol=true data-highlight=true>{{ $amount }}</span>'
                )
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
                    @can("customer.update")
                        <li><a href="{{action(\'RegularBalanceController@edit\', [$id])}}" class="edit_regular_balance_button"><i class="glyphicon glyphicon-edit"></i> @lang("messages.edit")</a></li>
                    @endcan
                    @can("customer.delete")
                        <li><a href="{{action(\'RegularBalanceController@destroy\', [$id])}}" class="delete_regular_balance_button"><i class="glyphicon glyphicon-trash"></i> @lang("messages.delete")</a></li>
                    @endcan
                    </ul></div>'
                )
                ->rawColumns([3, 4])
                ->make(false);
        }

        return view('contact.regular_balance.index')->with(compact('type'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        if (!auth()->user()->can('supplier.create') && !auth()->user()->can('customer.create')) {
            abort(403, 'Unauthorized action.');
        }

        $business_id = request()->session()->get('user.business_id');

        //Check if subscribed or not
        if (!$this->moduleUtil->isSubscribed($business_id)) {
            return $this->moduleUtil->expiredResponse();
        }

        $type = request()->get('type');
        $customers = Contact::where('business_id', $business_id)
            ->where('type', $type)
            ->pluck('name', 'id');

        return view('contact.regular_balance.create')
            ->with(compact('customers'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store()
    {
        if (!auth()->user()->can('supplier.create') && !auth()->user()->can('customer.create')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $business_id = request()->session()->get('user.business_id');

            if (!$this->moduleUtil->isSubscribed($business_id)) {
                return $this->moduleUtil->expiredResponse();
            }

            $input = request()->only(['contact_id', 'receive_date', 'amount', 'additional_notes']);
            $input['business_id'] = $business_id;
            $input['created_by'] = request()->session()->get('user.id');

            /// Check Created Sale Invoices For Customer

			$sale_invoices = Transaction::where('contact_id', '=', $input['contact_id'])
				->where('type', '=', 'sell')
				->where('status', '=', 'final')
				->where('payment_status', '!=', 'paid')
				->where('business_id', '=', $input['business_id'])->get();

			$sz = count($sale_invoices);
			if ($sz == 0) {
				$output = ['success' => false,
					'msg' => __("contact.no_sale_invoices")
				];
			} else {
				$regular_balance = RegularBalance::create($input);

				if(!empty(request()->input('amount'))) {
					$this->transactionUtil->createRegularBalanceTransaction($business_id, request()->input('contact_id'), request()->input('amount'), $regular_balance->id);
				}

				$output = ['success' => true,
					'msg' => __("contact.added_success")
				];
			}

        } catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());

            $output = ['success' => false,
                'msg' =>__("messages.something_went_wrong")
            ];
        }

        return $output;
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        if (!auth()->user()->can('supplier.view') && !auth()->user()->can('customer.view')) {
            abort(403, 'Unauthorized action.');
        }

        $contact = Contact::where('contacts.id', $id)
            ->join('transactions AS t', 'contacts.id', '=', 't.contact_id')
            ->select(
                DB::raw("SUM(IF(t.type = 'purchase', final_total, 0)) as total_purchase"),
                DB::raw("SUM(IF(t.type = 'sell', final_total, 0)) as total_invoice"),
                DB::raw("SUM(IF(t.type = 'purchase', (SELECT SUM(amount) FROM transaction_payments WHERE transaction_payments.transaction_id=t.id), 0)) as purchase_paid"),
                DB::raw("SUM(IF(t.type = 'sell', (SELECT SUM(IF(is_return = 1,-1*amount,amount)) FROM transaction_payments WHERE transaction_payments.transaction_id=t.id), 0)) as invoice_received"),
                DB::raw("SUM(IF(t.type = 'opening_balance', final_total, 0)) as opening_balance"),
                DB::raw("SUM(IF(t.type = 'opening_balance', (SELECT SUM(amount) FROM transaction_payments WHERE transaction_payments.transaction_id=t.id), 0)) as opening_balance_paid"),
                'contacts.*'
            )->first();
        return view('contact.show')
            ->with(compact('contact'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        if (!auth()->user()->can('supplier.update') && !auth()->user()->can('customer.update')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            $business_id = request()->session()->get('user.business_id');

            $balance = RegularBalance::where('business_id', $business_id)->find($id);

            if (!$this->moduleUtil->isSubscribed($business_id)) {
                return $this->moduleUtil->expiredResponse();
            }

            $customers = Contact::where('business_id', $business_id)
                ->where('type', 'customer')
                ->pluck('name', 'id');

            return view('contact.regular_balance.edit')
                ->with(compact('balance', 'customers'));
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {

        if (!auth()->user()->can('supplier.update') && !auth()->user()->can('customer.update')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            try {
                $business_id = $request->session()->get('user.business_id');

	            $input = request()->only(['contact_id', 'receive_date', 'amount', 'additional_notes']);
	            $input['business_id'] = $business_id;
	            $input['created_by'] = request()->session()->get('user.id');


                if (!$this->moduleUtil->isSubscribed($business_id)) {
                    return $this->moduleUtil->expiredResponse();
                }

                $balance = RegularBalance::where('business_id', $business_id)->findOrFail($id);

	            $transaction_payments = TransactionPayment::where('parent_id', '=', $id)->get();
	            foreach ($transaction_payments as $payment) {
		            $payment->delete();
		            $this->transactionUtil->updatePaymentStatus($payment->transaction_id);
	            }

	            $balance->delete();

	            $sale_invoices = Transaction::where('contact_id', '=', $input['contact_id'])
		            ->where('type', '=', 'sell')
		            ->where('status', '=', 'final')
		            ->where('payment_status', '!=', 'paid')
		            ->where('business_id', '=', $input['business_id'])->get();

	            $sz = count($sale_invoices);
	            if ($sz == 0) {
		            $output = ['success' => false,
			            'msg' => __("contact.no_sale_invoices")
		            ];
	            } else {
		            $regular_balance = RegularBalance::create($input);

		            if(!empty(request()->input('amount'))) {
			            $this->transactionUtil->createRegularBalanceTransaction($business_id, request()->input('contact_id'), request()->input('amount'), $regular_balance->id);
		            }

		            $output = ['success' => true,
			            'msg' => __("contact.updated_success")
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
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if (!auth()->user()->can('supplier.delete') && !auth()->user()->can('customer.delete')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            try {
                $business_id = request()->user()->business_id;

                $balance = RegularBalance::where('business_id', $business_id)->findOrFail($id);

                $transaction_payments = TransactionPayment::where('parent_id', '=', $id)->get();
                foreach ($transaction_payments as $payment) {
                	$payment->delete();
	                $this->transactionUtil->updatePaymentStatus($payment->transaction_id);
                }

                $balance->delete();

                $output = ['success' => true,
                    'msg' => __("contact.deleted_success")
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

    public function checkRegularBalanceAmount(Request $request) {
        $amount = $request->input('amount');
        $valid = 'true';
        if (!empty($amount)) {
            if ($amount <= 0.0001) {
                $valid = 'false';
            }
        }
        echo $valid;
        exit;
    }
}
