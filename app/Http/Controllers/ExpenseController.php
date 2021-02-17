<?php

namespace App\Http\Controllers;

use App\Business;
use Illuminate\Http\Request;

use App\Transaction;
use App\ExpenseCategory;
use App\BusinessLocation;
use App\User;
use App\Bank;
use App\Currency;

use Validator;

use Yajra\DataTables\Facades\DataTables;

use App\Utils\TransactionUtil;
use App\Utils\ModuleUtil;

use DB;
use Log;

class ExpenseController extends Controller
{
    /**
    * Constructor
    *
    * @param TransactionUtil $transactionUtil
    * @return void
    */
    public function __construct(TransactionUtil $transactionUtil, ModuleUtil $moduleUtil)
    {
        $this->transactionUtil = $transactionUtil;
        $this->moduleUtil = $moduleUtil;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (!auth()->user()->can('expense.access')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            $business_id = request()->session()->get('user.business_id');

            $expenses = Transaction::leftJoin('expense_categories AS ec', 'transactions.expense_category_id', '=', 'ec.id')
                        ->join(
                            'business_locations AS bl',
                            'transactions.location_id',
                            '=',
                            'bl.id'
                        )
                        ->leftJoin('bank', 'bank.id', '=', 'transactions.bank_id')
                        ->leftJoin('users AS U', 'transactions.expense_for', '=', 'U.id')
                        ->where('transactions.business_id', $business_id)
                        ->where('transactions.type', 'expense')
                        ->select(
                            'transactions.id',
                            'document',
                            'transaction_date',
                            'ref_no',
                            'ec.name as category',
                            'payment_status',
                            'additional_notes',
                            'final_total',
//                            'bl.name as location_name',
                            'bank.name as bank_name',
                            DB::raw("CONCAT(COALESCE(U.surname, ''),' ',COALESCE(U.first_name, ''),' ',COALESCE(U.last_name,'')) as expense_for")
                        );

            //Add condition for expense for,used in sales representative expense report
            if (request()->has('expense_for')) {
                $expense_for = request()->get('expense_for');
                if (!empty($expense_for)) {
                    $expenses->where('transactions.expense_for', $expense_for);
                }
            }

            //Add condition for location,used in sales representative expense report
            if (request()->has('location_id')) {
                $location_id = request()->get('location_id');
                if (!empty($location_id)) {
                    $expenses->where('transactions.location_id', $location_id);
                }
            }

            //Add condition for start and end date filter, uses in sales representative expense report
            if (!empty(request()->start_date) && !empty(request()->end_date)) {
                $start = request()->start_date;
                $end =  request()->end_date;
                $expenses->whereDate('transaction_date', '>=', $start)
                        ->whereDate('transaction_date', '<=', $end);
            }

            $permitted_locations = auth()->user()->permitted_locations();
            if ($permitted_locations != 'all') {
                $expenses->whereIn('transactions.location_id', $permitted_locations);
            }
            
            return Datatables::of($expenses)
                ->addColumn(
                    'action',
                    '<div class="btn-group">
                        <button type="button" class="btn btn-info dropdown-toggle btn-xs" 
                            data-toggle="dropdown" aria-expanded="false"> @lang("messages.actions")<span class="caret"></span><span class="sr-only">Toggle Dropdown
                                </span>
                        </button>
                    <ul class="dropdown-menu dropdown-menu-right" role="menu">
                    <li><a href="{{action(\'ExpenseController@edit\', [$id])}}"><i class="glyphicon glyphicon-edit"></i> @lang("messages.edit")</a></li>
                    @if($document)
                        <li><a href="{{ url(\'storage/documents/\' . $document)}}" 
                        download="@if(!empty(explode(\'_\', $document, 2)[1])){{explode(\'_\', $document, 2)[1]}}@else{{$document}}@endif"><i class="fa fa-download" aria-hidden="true"></i> @lang("purchase.download_document")</a></li>
                    @endif
                    <li>
                        <a data-href="{{action(\'ExpenseController@destroy\', [$id])}}" class="delete_expense"><i class="glyphicon glyphicon-trash"></i> @lang("messages.delete")</a></li> </ul></div>'
                )
                ->removeColumn('id')
                ->editColumn(
                    'final_total',
                    '<span class="display_currency final-total" data-currency_symbol="true" data-orig-value="{{$final_total}}">{{$final_total}}</span>'
                )
                ->editColumn('transaction_date', '{{@format_date($transaction_date)}}')
                ->editColumn(
                    'payment_status',
                    '<span class="label @payment_status($payment_status) payment-status" data-orig-value="{{$payment_status}}" data-status-name="{{__(\'lang_v1.\' . $payment_status)}}" >{{__(\'lang_v1.\' . $payment_status)}}
                        </span>'
                )
                ->rawColumns(['final_total', 'action', 'payment_status'])
                ->make(true);
        }
        return view('expense.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        if (!auth()->user()->can('expense.access')) {
            abort(403, 'Unauthorized action.');
        }

        $business_id = request()->session()->get('user.business_id');
        
        //Check if subscribed or not
        if (!$this->moduleUtil->isSubscribed($business_id)) {
            return $this->moduleUtil->expiredResponse(action('ExpenseController@index'));
        }
        $banks = Bank::where('business_id', '=', $business_id)->pluck('name', 'id');
        $business_locations = BusinessLocation::forDropdown($business_id);

        $expense_categories = ExpenseCategory::where('business_id', $business_id)
                                ->pluck('name', 'id');
        $users = User::forDropdown($business_id);

	    $currencies = Currency::where('currency_rate', '>', 0)->pluck('code', 'id');
	    $business = Business::where('id', $business_id)->first();
	    $default_currency_id = $business->currency_id;

        return view('expense.create')
            ->with(compact('expense_categories', 'business_locations', 'users', 'banks', 'currencies', 'default_currency_id'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if (!auth()->user()->can('expense.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $business_id = $request->session()->get('user.business_id');

            //Check if subscribed or not
            if (!$this->moduleUtil->isSubscribed($business_id)) {
                return $this->moduleUtil->expiredResponse(action('ExpenseController@index'));
            }

            //Validate document size
            $request->validate([
                'document' => 'file|max:'. (config('constants.document_size_limit') / 1000)
            ]);

            $transaction_data = $request->only([ 'ref_no', 'transaction_date', 'bank_id', 'final_total', 'payment_status', 'expense_for', 'additional_notes', 'expense_category_id']);

			$currency = Currency::findOrFail(request()->input('exchange_rate_list'));

            $user_id = $request->session()->get('user.id');
            $transaction_data['business_id'] = $business_id;
            $transaction_data['created_by'] = $user_id;
            $transaction_data['type'] = 'expense';
            $transaction_data['status'] = 'final';
            $transaction_data['transaction_date'] = $this->transactionUtil->uf_date($transaction_data['transaction_date']);
            $transaction_data['final_total'] = $this->transactionUtil->num_uf(
                $transaction_data['final_total'] / $currency->currency_rate
            );
            $bl = BusinessLocation::where('business_id', '=', $business_id)->first();
            $transaction_data['location_id'] = $bl['id'];


            $amount = $transaction_data['final_total'];

	        $bank = Bank::LeftJoin('transactions as t', 't.bank_id', '=', 'bank.id')
		        ->LeftJoin(
			        'transaction_payments AS tp',
			        't.id',
			        '=',
			        'tp.transaction_id'
		        )
		        ->where('bank.id', '=', $transaction_data['bank_id'])
		        ->where('bank.business_id', '=', $business_id)
		        ->select(
			        DB::raw('
                    (SUM(IF(t.type = "sell", tp.amount, 0))
                     + SUM(IF(t.type = "purchase", -1*tp.amount, 0))
                     + SUM(IF(t.type = "bank_payment", t.final_total, 0))
                     - SUM(IF(t.type = "expense" and t.payment_status = "paid", t.final_total, 0))
                     + SUM(IF(t.type = "sell_return", -1 * t.final_total, 0))) 
                     as balance
                ')
		        )->first();

	        $bank_balance = $this->transactionUtil->num_uf($bank->balance);

	        if ($bank_balance < $amount && $transaction_data['payment_status'] == 'paid') {
		        $output = ['success' => 0,
			        'msg' => __('purchase.check_bank_balance')
		        ];
	        } else {

		        //Update reference count
		        $ref_count = $this->transactionUtil->setAndGetReferenceCount('expense');
		        //Generate reference number
		        if (empty($transaction_data['ref_no'])) {
			        $transaction_data['ref_no'] = $this->transactionUtil->generateReferenceNumber('expense', $ref_count);
		        }

		        //upload document
		        if ($request->hasFile('document') && $request->file('document')->isValid()) {
			        if ($request->document->getSize() <= config('constants.document_size_limit')) {
				        $new_file_name = time() . '_' . $request->document->getClientOriginalName();
				        $path = $request->document->storeAs('public/documents', $new_file_name);
				        $transaction_data['document'] = str_replace('public/documents/', '', $path);
			        }
		        }

		        $transaction = Transaction::create($transaction_data);

		        $output = ['success' => 1,
			        'msg' => __('expense.expense_add_success')
		        ];
	        }

        } catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
            
            $output = ['success' => 0,
                            'msg' => __('messages.something_went_wrong')
                        ];
        }

        return redirect('expenses')->with('status', $output);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        if (!auth()->user()->can('expense.access')) {
            abort(403, 'Unauthorized action.');
        }

        $business_id = request()->session()->get('user.business_id');

        //Check if subscribed or not
        if (!$this->moduleUtil->isSubscribed($business_id)) {
            return $this->moduleUtil->expiredResponse(action('ExpenseController@index'));
        }

        $business_locations = BusinessLocation::forDropdown($business_id);
        $banks = Bank::where('business_id', '=', $business_id)->pluck('name', 'id');

        $expense_categories = ExpenseCategory::where('business_id', $business_id)
                                ->pluck('name', 'id');
        $expense = Transaction::where('business_id', $business_id)
                                ->where('id', $id)
                                ->first();
        $users = User::forDropdown($business_id);
	    $currencies = Currency::where('currency_rate', '>', 0)->pluck('code', 'id');
	    $business = Business::where('id', $business_id)->first();
	    $default_currency_id = $business->currency_id;

        return view('expense.edit')
            ->with(compact('expense', 'expense_categories', 'business_locations', 'users', 'banks', 'currencies', 'default_currency_id'));
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
        if (!auth()->user()->can('expense.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            //Validate document size
            $request->validate([
                'document' => 'file|max:'. (config('constants.document_size_limit') / 1000)
            ]);

            $transaction_data = $request->only([ 'ref_no', 'transaction_date', 'bank_id', 'final_total', 'payment_status', 'expense_for', 'additional_notes', 'expense_category_id']);

            $business_id = $request->session()->get('user.business_id');

            $bl = BusinessLocation::where('business_id', '=', $business_id)->first();
            $transaction_data['location_id'] = $bl['id'];

            //Check if subscribed or not
            if (!$this->moduleUtil->isSubscribed($business_id)) {
                return $this->moduleUtil->expiredResponse(action('ExpenseController@index'));
            }

            $currency = Currency::findOrFail(request()->input('exchange_rate_list'));
            $transaction_data['transaction_date'] = \Carbon::createFromFormat(
                'm/d/Y',
                $transaction_data['transaction_date']
            )->toDateString();
            $transaction_data['final_total'] = $this->transactionUtil->num_uf(
                $transaction_data['final_total'] / $currency->currency_rate
            );

	        $amount = $transaction_data['final_total'];

	        $bank = Bank::LeftJoin('transactions as t', 't.bank_id', '=', 'bank.id')
		        ->LeftJoin(
			        'transaction_payments AS tp',
			        't.id',
			        '=',
			        'tp.transaction_id'
		        )
		        ->where('bank.id', '=', $transaction_data['bank_id'])
		        ->where('bank.business_id', '=', $business_id)
		        ->select(
			        DB::raw('
                    (SUM(IF(t.type = "sell", tp.amount, 0))
                     + SUM(IF(t.type = "purchase", -1*tp.amount, 0))
                     + SUM(IF(t.type = "bank_payment", t.final_total, 0))
                     - SUM(IF(t.type = "expense" and t.payment_status = "paid", t.final_total, 0))
                     + SUM(IF(t.type = "sell_return", -1 * t.final_total, 0))) 
                     as balance
                ')
		        )->first();

	        $bank_balance = $this->transactionUtil->num_uf($bank->balance);

	        if ($bank_balance < $amount && $transaction_data['payment_status'] == 'paid') {
		        $output = ['success' => 0,
			        'msg' => __('purchase.check_bank_balance')
		        ];
	        } else {

		        //upload document
		        if ($request->hasFile('document') && $request->file('document')->isValid()) {
			        if ($request->document->getSize() <= config('constants.document_size_limit')) {
				        $new_file_name = time() . '_' . $request->document->getClientOriginalName();
				        $path = $request->document->storeAs('public/documents', $new_file_name);
				        $transaction_data['document'] = str_replace('public/documents/', '', $path);
			        }
		        }

		        $transaction = Transaction::where('business_id', $business_id)
			        ->where('id', $id)
			        ->update($transaction_data);

		        $output = ['success' => 1,
			        'msg' => __('expense.expense_update_success')
		        ];
	        }

        } catch (\Exception $e) {
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
            
            $output = ['success' => 0,
                            'msg' => __('messages.something_went_wrong')
                        ];
        }

        return redirect('expenses')->with('status', $output);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        if (!auth()->user()->can('expense.access')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            try {
                $business_id = request()->session()->get('user.business_id');

                $expense = Transaction::where('business_id', $business_id)
                                        ->where('type', 'expense')
                                        ->where('id', $id)
                                        ->first();
                $expense->delete();

                $output = ['success' => true,
                            'msg' => __("expense.expense_delete_success")
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
}
