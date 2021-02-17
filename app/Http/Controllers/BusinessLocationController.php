<?php

namespace App\Http\Controllers;

use App\PurchaseLine;
use App\Transaction;
use App\BusinessLocation;
use App\InvoiceLayout;
use App\InvoiceScheme;
    
use Yajra\DataTables\Facades\DataTables;
use Illuminate\Http\Request;
use Spatie\Permission\Models\Permission;

use App\Utils\Util;
use App\Utils\ModuleUtil;
use App\Utils\ProductUtil;
use App\Utils\TransactionUtil;

use DB;
use Log;

class BusinessLocationController extends Controller
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

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        if (request()->ajax()) {
            $business_id = request()->session()->get('user.business_id');

            $locations = BusinessLocation::where('business_locations.business_id', $business_id)
                ->leftjoin(
                    'invoice_schemes as ic',
                    'business_locations.invoice_scheme_id',
                    '=',
                    'ic.id'
                )
                ->leftjoin(
                    'invoice_layouts as il',
                    'business_locations.invoice_layout_id',
                    '=',
                    'il.id'
                )
                ->select(['business_locations.name', 'city', 'business_locations.id']);

            $permitted_locations = auth()->user()->permitted_locations();
            if ($permitted_locations != 'all') {
                $locations->whereIn('business_locations.id', $permitted_locations);
            }

            return Datatables::of($locations)
                ->addColumn(
                    'action',
                    '
                    <a href="{{action(\'BusinessLocationController@show\', [$id])}}" class="btn btn-primary btn-xs" aria-hidden="true"><i class="fa fa-eye-slash" aria-hidden="true"></i></a> &nbsp;
                    <button type="button" data-href="{{action(\'BusinessLocationController@edit\', [$id])}}" class="btn btn-xs btn-primary btn-modal" data-container=".location_edit_modal"><i class="glyphicon glyphicon-edit"></i> @lang("messages.edit")</button>
                    <a data-href="{{action(\'BusinessLocationController@destroy\', [$id])}}" class="btn btn-danger btn-xs delete_business_location"><i class="glyphicon glyphicon-trash"></i> @lang("messages.delete")</a>
                    '
                )
                ->removeColumn('id')
                ->rawColumns([2])
                ->make(false);
        }

        return view('business_location.index');
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }
        $business_id = request()->session()->get('user.business_id');

        //Check if subscribed or not, then check for location quota
        if (!$this->moduleUtil->isSubscribed($business_id)) {
            return $this->moduleUtil->expiredResponse();
        } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
            return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
        }

//        $invoice_layouts = InvoiceLayout::where('business_id', $business_id)
//                            ->get()
//                            ->pluck('name', 'id');
//
//        $invoice_schemes = InvoiceScheme::where('business_id', $business_id)
//                            ->get()
//                            ->pluck('name', 'id');
//        return view('business_location.create')->with(compact('invoice_layouts', 'invoice_schemes'));
        return view('business_location.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            $business_id = $request->session()->get('user.business_id');

            //Check if subscribed or not, then check for location quota
            if (!$this->moduleUtil->isSubscribed($business_id)) {
                return $this->moduleUtil->expiredResponse();
            } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
                return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
            }

//            $input = $request->only(['name', 'landmark', 'city', 'state', 'country', 'zip_code', 'invoice_scheme_id',
//                'invoice_layout_id', 'mobile', 'alternate_number', 'email', 'website', 'custom_field1', 'custom_field2', 'custom_field3', 'custom_field4', 'location_id']);
            $input = $request->only(['name', 'city']);
            $input['business_id'] = $business_id;

            //Update reference count
//            $ref_count = $this->commonUtil->setAndGetReferenceCount('business_location');

//            if (empty($input['location_id'])) {
//                $input['location_id'] = $this->commonUtil->generateReferenceNumber('business_location', $ref_count);
//            }

            $location = BusinessLocation::create($input);

            //Create a new permission related to the created location
            Permission::create(['name' => 'location.' . $location->id ]);

            $output = ['success' => true,
                            'msg' => __("inventory.inventory_added_success")
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
     * Display the specified resource.
     *
     * @param  \App\StoreFront  $storeFront
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request, $id)
    {
        if (!auth()->user()->can('inventory.view')) {
            abort(403, 'Unauthorized action.');
        }

        $inventory = BusinessLocation::findOrFail($id);
        $inventory_name = $inventory->name;
        $inventory_id = $id;

        if ($request->ajax()) {
            $location_id = $id;

            $business_id = $request->session()->get('user.business_id');

            $hasExpireDate = request()->get('expired');
            $zeroQuantity = request()->get('zeroQuantity');

            $products = PurchaseLine::LeftJoin('transactions', 'purchase_lines.transaction_id', '=', 'transactions.id')
                ->LeftJoin('products', 'purchase_lines.product_id', '=', 'products.id')
	            ->LeftJoin('variations as v', 'v.id', '=', 'purchase_lines.variation_id')
                ->select('products.name',
                    'products.ref_number',
                    'purchase_lines.purchase_price_inc_tax as dpp',
                    'quantity', 'quantity_sold', 'quantity_adjusted',
                    DB::raw("quantity - quantity_sold - quantity_adjusted as remaining_quantity"),
                    'exp_date'
                )
                ->when($hasExpireDate, function ($query, $hasExpireDate) {
                    if($hasExpireDate == 'true') {
                        $sql = '(exp_date >= "' . date("Y-m-d") . '" or exp_date is NULL)';
                        return $query->whereRaw($sql);
                    }
                    return $query;
                })
                ->when($zeroQuantity, function ($query, $zeroQuantity) {
                    if ($zeroQuantity == 'true') {
                        return $query->having('remaining_quantity', '>', 0);
                    }
                })
                ->where('transactions.location_id', '=', $location_id)
                ->where('transactions.business_id', '=', $business_id)
	            ->where('transactions.status', '=', 'received');

            return Datatables::of($products)
                ->editColumn(
                    'dpp',
                    '<span class="input-number">$ {{ $dpp }}</span>'
                )
	            ->removeColumn('quantity')
	            ->removeColumn('quantity_sold')
	            ->removeColumn('quantity_adjusted')
                ->rawColumns([2])
                ->make(false);
        }

        return view('inventory.show')->with(compact('inventory_name', 'inventory_id'));
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\StoreFront  $storeFront
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        $business_id = request()->session()->get('user.business_id');
        $location = BusinessLocation::where('business_id', $business_id)
                                    ->findOrFail($id);

        $count = Transaction::where('business_id', '=', $business_id)
	        ->where('location_id', $id)
	        ->count();

	    if ($count == 0) {
		    return view('business_location.edit')->with(compact('location'));
	    }
	    else {
		    return redirect('inventory.index');
	    }
//        $invoice_layouts = InvoiceLayout::where('business_id', $business_id)
//                            ->get()
//                            ->pluck('name', 'id');
//        $invoice_schemes = InvoiceScheme::where('business_id', $business_id)
//                            ->get()
//                            ->pluck('name', 'id');

//        return view('business_location.edit')->with(compact('location', 'invoice_layouts', 'invoice_schemes'));

    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\StoreFront  $storeFront
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        if (!auth()->user()->can('business_settings.access')) {
            abort(403, 'Unauthorized action.');
        }

        try {
//            $input = $request->only(['name', 'landmark', 'city', 'state', 'country', 'zip_code', 'invoice_scheme_id',
//                'invoice_layout_id', 'mobile', 'alternate_number', 'email', 'website', 'custom_field1', 'custom_field2', 'custom_field3', 'custom_field4']);
            $input = $request->only(['name', 'city']);
            
            $business_id = $request->session()->get('user.business_id');

            BusinessLocation::where('business_id', $business_id)
                            ->where('id', $id)
                            ->update($input);

            $output = ['success' => 1,
                            'msg' => __('inventory.inventory_updated_success')
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

                //Check if subscribed or not, then check for location quota
                if (!$this->moduleUtil->isSubscribed($business_id)) {
                    return $this->moduleUtil->expiredResponse();
                } elseif (!$this->moduleUtil->isQuotaAvailable('locations', $business_id)) {
                    return $this->moduleUtil->quotaExpiredResponse('locations', $business_id);
                }

                //Check if any transaction related to this contact exists
                $count = Transaction::where('business_id', $business_id)
                    ->where('location_id', $id)
                    ->count();
                if ($count == 0) {
                    $inventory = BusinessLocation::where('business_id', $business_id)->findOrFail($id);
                    $inventory->delete();
                    $output = ['success' => true,
                        'msg' => __("inventory.deleted_success")
                    ];
                } else {
                    $output = ['success' => false,
                        'msg' => __("lang_v1.you_cannot_delete_this_inventory")
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
    public function checkLocationId(Request $request)
    {
        $city = $request->input('city');

        $valid = 'true';
        if (!empty($city)) {
            $business_id = $request->session()->get('user.business_id');

            $query = BusinessLocation::where('business_id', $business_id)
                            ->where('city', $city);
            $count = $query->count();
            if ($count > 0) {
                $valid = 'false';
            }
        }
        echo $valid;
        exit;
    }
}
