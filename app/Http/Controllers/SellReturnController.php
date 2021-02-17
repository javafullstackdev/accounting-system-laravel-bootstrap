<?php

namespace App\Http\Controllers;

use App\Contact;
use App\TransactionSellLine;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\BusinessLocation;
use App\Transaction;
use App\TaxRate;
use App\Bank;

use App\Utils\ProductUtil;
use App\Utils\TransactionUtil;
use App\Utils\ContactUtil;
use App\Utils\BusinessUtil;
use App\Utils\ModuleUtil;

use Yajra\DataTables\Facades\DataTables;
use Log;
use App\PurchaseLine;
class SellReturnController extends Controller
{
    /**
     * All Utils instance.
     *
     */
    protected $productUtil;
    protected $transactionUtil;
    protected $contactUtil;
    protected $businessUtil;
    protected $moduleUtil;

    /**
     * Constructor
     *
     * @param ProductUtils $product
     * @return void
     */
    public function __construct(ProductUtil $productUtil, TransactionUtil $transactionUtil, ContactUtil $contactUtil, BusinessUtil $businessUtil, ModuleUtil $moduleUtil)
    {
        $this->productUtil = $productUtil;
        $this->transactionUtil = $transactionUtil;
        $this->contactUtil = $contactUtil;
        $this->businessUtil = $businessUtil;
        $this->moduleUtil = $moduleUtil;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (!auth()->user()->can('sell.view') && !auth()->user()->can('sell.create')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            $business_id = request()->session()->get('user.business_id');

            $sells = Transaction::leftJoin('contacts', 'transactions.contact_id', '=', 'contacts.id')
                    
                    ->join(
                        'business_locations AS bl',
                        'transactions.location_id',
                        '=',
                        'bl.id'
                    )
                    ->where('transactions.business_id', $business_id)
                    ->where('transactions.type', 'sell_return')
                    ->where('transactions.status', 'final')
                    ->select(
                        'transactions.id',
                        'transaction_date',
                        'invoice_no',
                        'contacts.name',
                        'final_total',
                        'bl.name as business_location'
                    );

            $permitted_locations = auth()->user()->permitted_locations();
            if ($permitted_locations != 'all') {
                $sells->whereIn('transactions.location_id', $permitted_locations);
            }

            //Add condition for created_by,used in sales representative sales report
            if (request()->has('created_by')) {
                $created_by = request()->get('created_by');
                if (!empty($created_by)) {
                    $sells->where('transactions.created_by', $created_by);
                }
            }

            //Add condition for location,used in sales representative expense report
            if (request()->has('location_id')) {
                $location_id = request()->get('location_id');
                if (!empty($location_id)) {
                    $sells->where('transactions.location_id', $location_id);
                }
            }

            if (!empty(request()->customer_id)) {
                $customer_id = request()->customer_id;
                $sells->where('contacts.id', $customer_id);
            }
            if (!empty(request()->start_date) && !empty(request()->end_date)) {
                $start = request()->start_date;
                $end =  request()->end_date;
                $sells->whereDate('transaction_date', '>=', $start)
                        ->whereDate('transaction_date', '<=', $end);
            }

            $sells->groupBy('transactions.id');

            return Datatables::of($sells)
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
                    @if(auth()->user()->can("sell.view") || auth()->user()->can("direct_sell.access") )
                        <li><a href="#" class="btn-modal" data-container=".view_modal" data-href="{{action(\'SellReturnController@show\', [$id])}}"><i class="fa fa-external-link" aria-hidden="true"></i> @lang("messages.view")</a></li>
                    @endif

                    @if(auth()->user()->can("sell.view") || auth()->user()->can("direct_sell.access") )
                        <li><a href="#" class="print-invoice" data-href="{{action(\'SellReturnController@printInvoice\', [$id])}}"><i class="fa fa-print" aria-hidden="true"></i> @lang("messages.print")</a></li>
                    @endif
                    @can("sell.delete")
                    <li><a href="{{action(\'SellReturnController@destroy\', [$id])}}" class="delete-sale"><i class="fa fa-trash"></i> @lang("messages.delete")</a></li>
                    @endcan
                    </ul>
                    </div>'
                )
                ->removeColumn('id')
                ->editColumn(
                    'final_total',
                    '<span class="display_currency" data-currency_symbol="true">{{$final_total}}</span>'
                )
                ->editColumn('transaction_date', '{{@format_date($transaction_date)}}')
                ->setRowAttr([
                    'data-href' => function ($row) {
                        if (auth()->user()->can("sell.view")) {
                            return  action('SellReturnController@show', [$row->id]) ;
                        } else {
                            return '';
                        }
                    }])
                ->rawColumns(['final_total', 'action'])
                ->make(true);
        }

        return view('sell_return.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        if (!auth()->user()->can('sell.create')) {
            abort(403, 'Unauthorized action.');
        }

        $business_id = request()->session()->get('user.business_id');

        //Check if subscribed or not
        if (!$this->moduleUtil->isSubscribed($business_id)) {
            return $this->moduleUtil->expiredResponse(action('SellReturnController@index'));
        }

        $business_locations = BusinessLocation::forDropdown($business_id);
        $contact_ids = Contact::where('business_id', '=', $business_id)->where('type', '=', 'customer')->pluck('name', 'id');
        $banks = Bank::where('business_id', '=', $business_id)->pluck('name', 'id');

        return view('sell_return.create')
            ->with(compact('business_locations', 'contact_ids', 'banks'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if (!auth()->user()->can('sell.create')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $input = $request->except('_token');

            if (!empty($input['products'])) {
                $business_id = $request->session()->get('user.business_id');

                //Check if subscribed or not
                if (!$this->moduleUtil->isSubscribed($business_id)) {
                    return $this->moduleUtil->expiredResponse(action('SellReturnController@index'));
                }
        
                $user_id = $request->session()->get('user.id');

                $discount = ['discount_type' => $input['discount_type'],
                                'discount_amount' => $input['discount_amount']
                            ];
                $invoice_total = $this->productUtil->calculateInvoiceTotal($input['products'], null, $discount);

                //Customer group details
                $contact_id = $request->get('contact_id', null);
                $cg = $this->contactUtil->getCustomerGroup($business_id, $contact_id);
                $input['customer_group_id'] = (empty($cg) || empty($cg->id)) ? null : $cg->id;
                $input['bank_id'] = $request->input('bank_id');

                DB::beginTransaction();

                $input['transaction_date'] = $this->productUtil->uf_date($request->input('transaction_date'));

                //Update reference count
                $ref_count = $this->productUtil->setAndGetReferenceCount('sell_return');
                //Generate reference number
                if (empty($input['invoice_no'])) {
                    $input['invoice_no'] = $this->productUtil->generateReferenceNumber('sell_return', $ref_count);
                } else {
                    $trans = Transaction::where('id', '=', $input['invoice_no'])->first();
                    $input['invoice_no'] = $trans['invoice_no'];
                }

                $transaction = $this->transactionUtil->createSellReturnTransaction($business_id, $input, $invoice_total, $user_id);

                $purchase_lines = [];
                $purchases = $request->input('products');
                foreach ($purchases as $purchase) {
                    $new_purchase_line = [
                    'product_id' => $purchase['product_id'],
                    'variation_id' => $purchase['variation_id'],
                    'quantity'=> $this->productUtil->num_uf($purchase['quantity']),
                    'pp_without_discount' => $this->productUtil->num_uf($purchase['unit_price']),
                    'discount_percent' => 0,
                    'purchase_price' => $this->productUtil->num_uf($purchase['unit_price']),
                    'item_tax'=>$this->productUtil->num_uf($purchase['item_tax']),
                    'tax_id' => $purchase['tax_id'],
                    'purchase_price_inc_tax' => $this->productUtil->num_uf($purchase['unit_price_inc_tax']),
                    'lot_number' => !empty($purchase['lot_number']) ? $purchase['lot_number'] : null
                    ];
                    
                    if (!empty($purchase['exp_date'])) {
                        $new_purchase_line['exp_date'] = $this->productUtil->uf_date($purchase['exp_date']);
                    }

                    $purchase_lines[] = $new_purchase_line;

                    // Update quantity
                    $this->productUtil->updateProductQuantity($input['location_id'], $purchase['product_id'], $purchase['variation_id'], $purchase['quantity']);
                }

                if (!empty($purchase_lines)) {
                    $transaction->purchase_lines()->createMany($purchase_lines);
                }

                $receipt = $this->receiptContent($business_id, $input['location_id'], $transaction->id);
                DB::commit();

                $output = ['success' => 1,
                            'msg' => __('lang_v1.success'),
                            'receipt' => $receipt
                        ];
            }
        } catch (\Exception $e) {
            DB::rollBack();

            if (get_class($e) == \App\Exceptions\PurchaseSellMismatch::class) {
                $msg = $e->getMessage();
            } else {
                \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
                $msg = trans("messages.something_went_wrong");
            }

            $output = ['success' => 0,
                            'msg' => $msg
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
        if (!auth()->user()->can('sell.view')) {
            abort(403, 'Unauthorized action.');
        }

        $business_id = request()->session()->get('user.business_id');
        $taxes = TaxRate::where('business_id', $business_id)
                            ->pluck('name', 'id');
        $purchase = Transaction::where('business_id', $business_id)
                                ->where('id', $id)
                                ->with(
                                    'contact',
                                    'purchase_lines',
                                    'purchase_lines.product',
                                    'purchase_lines.variations',
                                    'purchase_lines.variations.product_variation',
                                    'location'
                                )
                                ->first();

        return view('sell_return.show')
            ->with(compact('taxes', 'purchase'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
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
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
	    if (!auth()->user()->can('sell.delete')) {
		    abort(403, 'Unauthorized action.');
	    }

	    if (request()->ajax()) {
		    try {
			    $business_id = request()->session()->get('user.business_id');
			    $transaction = Transaction::where('id', $id)
				    ->where('business_id', $business_id)
				    ->where('type', 'sell')
				    ->with(['sell_lines'])
				    ->first();
			    //Begin transaction
			    DB::beginTransaction();

			    if (!empty($transaction)) {
				    //If status is draft direct delete transaction
				    if ($transaction->status == 'draft') {
					    $transaction->delete();
				    } else {
					    $deleted_sell_lines = $transaction->sell_lines;
					    $deleted_sell_lines_ids = $deleted_sell_lines->pluck('id')->toArray();
					    $this->transactionUtil->deleteSellLines(
						    $deleted_sell_lines_ids,
						    $transaction->location_id
					    );

					    $transaction->status = 'draft';
					    $business = ['id' => $business_id,
						    'accounting_method' => request()->session()->get('business.accounting_method'),
						    'location_id' => $transaction->location_id
					    ];

					    $this->transactionUtil->adjustMappingPurchaseSell('final', $transaction, $business, $deleted_sell_lines_ids);

					    $transaction->delete();
				    }
			    }
			    DB::commit();
			    $output = [
				    'success' => true,
				    'msg' => __('lang_v1.sale_delete_success')
			    ];
		    } catch (\Exception $e) {
			    DB::rollBack();
			    \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());

			    $output['success'] = false;
			    $output['msg'] = trans("messages.something_went_wrong");
		    }

		    return $output;
	    }
    }

    /**
     * Return the row for the product
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function getProductRow()
    {
    }

    /**
     * Returns the content for the receipt
     *
     * @param  int  $business_id
     * @param  int  $location_id
     * @param  int  $transaction_id
     * @param string $printer_type = null
     *
     * @return array
     */
    private function receiptContent(
        $business_id,
        $location_id,
        $transaction_id,
        $printer_type = null
    ) {
    
        $output = ['is_enabled' => false,
                    'print_type' => 'browser',
                    'html_content' => null,
                    'printer_config' => [],
                    'data' => []
                ];

        $business_details = $this->businessUtil->getDetails($business_id);
        $location_details = BusinessLocation::find($location_id);

        //Check if printing of invoice is enabled or not.
        if ($location_details->print_receipt_on_invoice == 1) {
            //If enabled, get print type.
            $output['is_enabled'] = true;

            $invoice_layout = $this->businessUtil->invoiceLayout($business_id, $location_id, $location_details->invoice_layout_id);

            //Check if printer setting is provided.
            $receipt_printer_type = is_null($printer_type) ? $location_details->receipt_printer_type : $printer_type;

            $receipt_details = $this->transactionUtil->getReceiptDetails($transaction_id, $location_id, $invoice_layout, $business_details, $location_details, $receipt_printer_type);
            $transaction = Transaction::findOrFail($transaction_id);

            $exp_dates = PurchaseLine::LeftJoin('transactions as t', 't.id', '=', 'purchase_lines.transaction_id')
                ->where('purchase_lines.transaction_id', '=', $transaction_id)
                ->select('exp_date')->get();

            $customer = Transaction::leftJoin('contacts as c', 'c.id', '=', 'transactions.contact_id')
                ->where('transactions.business_id', '=', $business_id)
                ->where('transactions.contact_id', '=', $transaction['contact_id'])
                ->select(
                    DB::raw("SUM(IF(transactions.type = 'opening_balance', final_total, 0))
                + SUM(IF(transactions.type = 'sell', transactions.final_total, 0)) 
                - SUM(IF(transactions.type = 'sell', (SELECT SUM(IF(is_return = 1,-1*amount,amount)) FROM transaction_payments WHERE transaction_payments.transaction_id=transactions.id), 0)) 
                - SUM(IF(transactions.type = 'sell_return', transactions.final_total, 0))
                as balances")
                )->get();
            $customer_balance = $customer[0]->balances;
            //If print type browser - return the content, printer - return printer config data, and invoice format config
            if ($receipt_printer_type == 'printer') {
                $output['print_type'] = 'printer';
                $output['printer_config'] = $this->businessUtil->printerConfig($business_id, $location_details->printer_id);
                $output['data'] = $receipt_details;
            } else {
                $output['html_content'] = view('sell_return.receipt', compact('receipt_details', 'exp_dates', 'customer_balance'))->render();
            }
        }

        return $output;
    }

    /**
     * Prints invoice for sell
     *
     * @param  \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function printInvoice(Request $request, $transaction_id)
    {
        if (request()->ajax()) {
            try {
                $output = ['success' => 0,
                        'msg' => trans("messages.something_went_wrong")
                        ];

                $business_id = $request->session()->get('user.business_id');
            
                $transaction = Transaction::where('business_id', $business_id)
                                ->where('id', $transaction_id)
                                ->first();

                if (empty($transaction)) {
                    return $output;
                }

                $receipt = $this->receiptContent($business_id, $transaction->location_id, $transaction_id, 'browser');

                if (!empty($receipt)) {
                    $output = ['success' => 1, 'receipt' => $receipt];
                }
            } catch (\Exception $e) {
                $output = ['success' => 0,
                        'msg' => trans("messages.something_went_wrong")
                        ];
            }

            return $output;
        }
    }

    public function get_customer_invoices(Request $request) {
        if (!empty($request->input('cid')) || !empty($request->input('location_id'))) {

            $contact_id = $request->input('cid');
            $location_id = $request->input('location_id');
            $business_id = $request->session()->get('user.business_id');
            $invoices = Transaction::where('business_id', $business_id)
                ->where('location_id', $location_id)
                ->where('contact_id', $contact_id)
                ->where('type', '=', 'sell')
                ->where('status', '=', 'final')
                ->select(['invoice_no', 'id'])
                ->get();
            $html = '<option value="">None</option>';
            if (!empty($invoices)) {
                foreach ($invoices as $invoice) {
                    $html .= '<option value="' . $invoice->id .'">' .$invoice->invoice_no . '</option>';
                }
            }
            echo $html;
            exit;
        }
    }
}
