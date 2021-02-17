<?php

namespace App\Http\Controllers;

use App\Bank;
use App\Business;
use App\BusinessLocation;
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

class BankPaymentController extends Controller
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

    public function create() {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        $bank_id = request()->get('bank_id');
        return view('bank.manual_payment.create')->with(compact('bank_id'));
    }

    public function store() {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $business_id = request()->session()->get('user.business_id');

            $input = request()->only(['receive_date', 'amount', 'bank_id']);
            $bank_id = request()->get('bank_id');
            $input['business_id'] = $business_id;
            $input['created_by'] = request()->session()->get('user.id');

            $location_id = BusinessLocation::where('business_id', '=', $business_id)->first();

            $manual_payment_data['type'] = "bank_payment";
            $manual_payment_data['location_id'] = $location_id['id'];
            $manual_payment_data['business_id'] = $input['business_id'];
            $manual_payment_data['bank_id'] = $bank_id;
            $manual_payment_data['created_by'] = $input['created_by'];
            $manual_payment_data['final_total'] = $input['amount'];
            $manual_payment_data['transaction_date'] = $input['receive_date'];

            $transaction = Transaction::create($manual_payment_data);

            $output = ['success' => true,
                'msg' => __("bank.add_manual_payment_success")
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
