<?php

namespace App\Http\Controllers;

use App\Currency;
use Illuminate\Http\Request;

use App\Product;
use App\Brands;
use App\Category;
use App\Unit;
use App\TaxRate;
use App\VariationTemplate;
use App\ProductVariation;
use App\Variation;
use App\Business;
use App\BusinessLocation;
use App\Transaction;

use App\Utils\ProductUtil;

use Excel;
use DB;
use Log;

class ImportProductsController extends Controller
{
    /**
     * All Utils instance.
     *
     */
    protected $productUtil;

    private $barcode_types;

    /**
     * Constructor
     *
     * @param ProductUtils $product
     * @return void
     */
    public function __construct(ProductUtil $productUtil)
    {
        $this->productUtil = $productUtil;

        //barcode types
        $this->barcode_types = $this->productUtil->barcode_types();
    }

    /**
     * Display import product screen.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        if (!auth()->user()->can('product.create')) {
            abort(403, 'Unauthorized action.');
        }

        $zip_loaded = extension_loaded('zip') ? true : false;

        //Check if zip extension it loaded or not.
        if ($zip_loaded === false) {
            $output = ['success' => 0,
                            'msg' => 'Please install/enable PHP Zip archive for import'
                        ];

            return view('import_products.index')
                ->with('notification', $output);
        } else {
            return view('import_products.index');
        }
    }

    /**
     * Imports the uploaded file to database.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        if (!auth()->user()->can('product.create')) {
            abort(403, 'Unauthorized action.');
        }

        try {
            //Set maximum php execution time
            ini_set('max_execution_time', 0);

            if ($request->hasFile('products_csv')) {
                $file = $request->file('products_csv');
                $imported_data = Excel::load($file->getRealPath())
                                ->noHeading()
                                ->skipRows(1)
                                ->get()
                                ->toArray();
                $business_id = $request->session()->get('user.business_id');
                $user_id = $request->session()->get('user.id');
                $default_profit_percent = $request->session()->get('business.default_profit_percent');

                $formated_data = [];

                $is_valid = true;
                $error_msg = '';
                
                DB::beginTransaction();
                foreach ($imported_data as $key => $value) {
                	if (empty($value[0]) && empty($value[1])) {
	                    break;
	                }
                    $row_no = $key + 1;
                    $product_array = [];
                    $product_array['business_id'] = $business_id;
                    $product_array['created_by'] = $user_id;
                    
                    //Add name
                    $product_name = trim($value[0]);
                    if (!empty($product_name)) {
                        $product_array['name'] = $product_name;
                        $count = Product::where('name', '=', $product_name)->where('business_id', '=', $business_id)->count();
                        if ($count > 0) {
	                        $is_valid =  false;
	                        $error_msg = "This product name already exists. $row_no";
	                        break;
                        }
                    } else {
                        $is_valid =  false;
                        $error_msg = "Product name is required in row no. $row_no";
                        break;
                    }

	                $ref_no = trim($value[1]);
	                if (!empty($ref_no)) {
		                $product_array['ref_number'] = $ref_no;
		                $count = Product::where('ref_number', '=', $ref_no)->where('business_id', '=', $business_id)->count();
		                if ($count > 0) {
			                $is_valid =  false;
			                $error_msg = "This product reference number already exists. $row_no";
			                break;
		                }
	                } else {
		                $is_valid =  false;
		                $error_msg = "Product reference number is required in row no. $row_no";
		                break;
	                }

	                //Add Brand
	                //Check if brand exists else create new
	                $brand_name = trim($value[2]);
	                if (!empty($brand_name)) {
		                $brand = Brands::firstOrCreate(
			                ['business_id' => $business_id, 'name' => $brand_name],
			                ['created_by' => $user_id]
		                );
		                $product_array['brand_id'] = $brand->id;
	                }

	                //Add Category
	                //Check if category exists else create new
	                $category_name = trim($value[3]);
	                if (!empty($category_name)) {
		                $category = Category::firstOrCreate(
			                ['business_id' => $business_id, 'name' => $category_name],
			                ['created_by' => $user_id, 'parent_id' => 0]
		                );
		                $product_array['category_id'] = $category->id;
	                }

                    //Add enable stock
                    $enable_stock = trim($value[4]);
	                if (!empty($enable_stock)) {
		                if (in_array($enable_stock, [0, 1])) {
			                $product_array['enable_stock'] = $enable_stock;
		                } else {
			                $is_valid = false;
			                $error_msg = "Invalid value for MANAGE STOCK in row no. $row_no";
			                break;
		                }
	                } else if ($enable_stock == 0) {
		                $product_array['enable_stock'] = $enable_stock;
	                } else {
		                $is_valid =  false;
		                $error_msg = "Invalid value for MANAGE STOCK in row no. $row_no";
		                break;
	                }

                    //Add product type
                    $product_type = 'single';
                    if (in_array($product_type, ['single','variable'])) {
                        $product_array['type'] = $product_type;
                    } else {
                        $is_valid =  false;
                        $error_msg = "Invalid value for PRODUCT TYPE in row no. $row_no";
                        break;
                    }

                    //Add barcode type
                    $barcode_type = null;
                    if (empty($barcode_type)) {
                        $product_array['barcode_type'] = 'C128';
                    } elseif (array_key_exists($barcode_type, $this->barcode_types)) {
                        $product_array['barcode_type'] = $barcode_type;
                    } else {
                        $is_valid = false;
                        $error_msg = "Invalid value for BARCODE TYPE in row no. $row_no";
                        break;
                    }

                    //Add tax type
                    $tax_type = 'exclusive';
                    if (in_array($tax_type, ['inclusive', 'exclusive'])) {
                        $product_array['tax_type'] = $tax_type;
                    } else {
                        $is_valid = false;
                        $error_msg = "Invalid value for Selling Price Tax Type in row no. $row_no";
                        break;
                    }

                    //Add alert quantity
                    $product_array['alert_quantity'] = 0;



                    //Add product expiry
                    $expiry_period = $this->productUtil->num_uf(trim($value[5]));
                    $expiry_period_type = strtolower(trim($value[6]));
                    if (!empty($expiry_period) && in_array($expiry_period_type, ['months', 'days'])) {
                        $product_array['expiry_period'] = $expiry_period;
                        $product_array['expiry_period_type'] = $expiry_period_type;
                    } else {
                        $product_array['expiry_period'] = 12;
                        $product_array['expiry_period_type'] = 'months';
                    }

                    if ($product_array['type'] == 'single') {
	                    //Calculate profit margin
	                    if (trim($value[7]) == 0 || trim($value[8]) == 0) {
	                    	Log::info($row_no);
		                    $product_array['variation']['profit_percent'] = 0;
	                    } else {
	                    	$profit = (trim($value[8]) - trim($value[7])) / trim($value[7]);
	                    	$profit = $profit * 100.0;
		                    $product_array['variation']['profit_percent'] = $profit;
	                    }

                        //Assign Values
                        $product_array['variation']['dpp_inc_tax'] = !empty(trim($value[7])) ? $this->productUtil->num_uf(trim($value[7])) : 0;
                        $product_array['variation']['dpp_exc_tax'] = !empty(trim($value[7])) ? $this->productUtil->num_uf(trim($value[7])) : 0;
                        $product_array['variation']['dsp_inc_tax'] = !empty(trim($value[8])) ? $this->productUtil->num_uf(trim($value[8])) : 0;
                        $product_array['variation']['dsp_exc_tax'] = !empty(trim($value[8])) ? $this->productUtil->num_uf(trim($value[8])) : 0;
                        
                    }
                    //Assign to formated array
                    $formated_data[] = $product_array;
                }

                if (!$is_valid) {
                    throw new \Exception($error_msg);
                }

//	            $business = Business::where('id', $business_id)->first();
//	            $default_currency_id = $business->currency_id;
	            $business = Business::where('id', $business_id)->first();
                $default_currency_id = $business->currency_id;
                $currency = Currency::findOrFail($default_currency_id);
                $currency_rate = $currency->currency_rate;

                if (!empty($formated_data)) {
                    foreach ($formated_data as $index => $product_data) {
                        $variation_data = $product_data['variation'];
                        unset($product_data['variation']);

                        //Create new product
                        $product = Product::create($product_data);
                        //If auto generate sku generate new sku
                        if ($product->sku == ' ') {
                            $sku = $this->productUtil->generateProductSku($product->id);
                            $product->sku = $sku;
                            $product->save();
                        }

                        //Create single product variation
                        if ($product->type == 'single') {
                            $this->productUtil->createSingleProductVariation(
                                $product,
                                $product->sku,
                                $variation_data['dpp_exc_tax'],
                                $variation_data['dpp_inc_tax'],
                                $variation_data['profit_percent'],
                                $variation_data['dsp_exc_tax'],
                                $variation_data['dsp_inc_tax'],
                                $currency_rate
                            );
                        }
                    }
                }
            }
            
            $output = ['success' => 1,
                            'msg' => __('product.file_imported_successfully')
                        ];

            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            \Log::emergency("File:" . $e->getFile(). "Line:" . $e->getLine(). "Message:" . $e->getMessage());
            
            $output = ['success' => 0,
                            'msg' => $e->getMessage()
                        ];
            return redirect('import-products')->with('notification', $output);
        }

        return redirect('import-products')->with('status', $output);
    }

    private function calculateVariationPrices($dpp_exc_tax, $dpp_inc_tax, $selling_price, $tax_amount, $tax_type, $margin)
    {

        //Calculate purchase prices
        if ($dpp_inc_tax == 0) {
            $dpp_inc_tax = $this->productUtil->calc_percentage(
                $dpp_exc_tax,
                $tax_amount,
                $dpp_exc_tax
            );
        }

        if ($dpp_exc_tax == 0) {
            $dpp_exc_tax = $this->productUtil->calc_percentage_base($dpp_inc_tax, $tax_amount);
        }

        if ($selling_price != 0) {
            if ($tax_type == 'inclusive') {
                $dsp_inc_tax = $selling_price;
                $dsp_exc_tax = $this->productUtil->calc_percentage_base(
                    $dsp_inc_tax,
                    $tax_amount
                );
            } elseif ($tax_type == 'exclusive') {
                $dsp_exc_tax = $selling_price;
                $dsp_inc_tax = $this->productUtil->calc_percentage(
                    $selling_price,
                    $tax_amount,
                    $selling_price
                );
            }
        } else {
            $dsp_exc_tax = $this->productUtil->calc_percentage(
                $dpp_exc_tax,
                $margin,
                $dpp_exc_tax
            );
            $dsp_inc_tax = $this->productUtil->calc_percentage(
                $dsp_exc_tax,
                $tax_amount,
                $dsp_exc_tax
            );
        }

        return [
            'dpp_exc_tax' => $this->productUtil->num_f($dpp_exc_tax),
            'dpp_inc_tax' => $this->productUtil->num_f($dpp_inc_tax),
            'dsp_exc_tax' => $this->productUtil->num_f($dsp_exc_tax),
            'dsp_inc_tax' => $this->productUtil->num_f($dsp_inc_tax)
        ];
    }

    /**
     * Adds opening stock of a single product
     *
     * @param array $opening_stock
     * @param obj $product
     * @param int $business_id
     * @return void
     */
    private function addOpeningStock($opening_stock, $product, $business_id)
    {

        $user_id = request()->session()->get('user.id');
        
        $variation = Variation::where('product_id', $product->id)
            ->first();

        $total_before_tax = $opening_stock['quantity'] * $variation->dpp_inc_tax;

        $transaction_date = request()->session()->get("financial_year.start");
        $transaction_date = \Carbon::createFromFormat('Y-m-d', $transaction_date)->toDateTimeString();
        //Add opening stock transaction
        $transaction = Transaction::create(
            [
                                'type' => 'opening_stock',
                                'opening_stock_product_id' => $product->id,
                                'status' => 'received',
                                'business_id' => $business_id,
                                'transaction_date' => $transaction_date,
                                'total_before_tax' => $total_before_tax,
                                'location_id' => $opening_stock['location_id'],
                                'final_total' => $total_before_tax,
                                'payment_status' => 'paid',
                                'created_by' => $user_id
                            ]
        );
        //Get product tax
        $tax_percent = !empty($product->product_tax->amount) ? $product->product_tax->amount : 0;
        $tax_id = !empty($product->product_tax->id) ? $product->product_tax->id : null;

        $item_tax = $this->productUtil->calc_percentage($variation->default_purchase_price, $tax_percent);

        //Create purchase line
        $transaction->purchase_lines()->create([
                        'product_id' => $product->id,
                        'variation_id' => $variation->id,
                        'quantity' => $opening_stock['quantity'],
                        'item_tax' => $item_tax,
                        'tax_id' => $tax_id,
                        'pp_without_discount' => $variation->default_purchase_price,
                        'purchase_price' => $variation->default_purchase_price,
                        'purchase_price_inc_tax' => $variation->dpp_inc_tax,
                        'exp_date' => !empty($opening_stock['exp_date']) ? $opening_stock['exp_date'] : null
                    ]);
        //Update variation location details
        $this->productUtil->updateProductQuantity($opening_stock['location_id'], $product->id, $variation->id, $opening_stock['quantity']);
    }


    private function addOpeningStockForVariable($variations, $product, $business_id)
    {
        $user_id = request()->session()->get('user.id');

        $transaction_date = request()->session()->get("financial_year.start");
        $transaction_date = \Carbon::createFromFormat('Y-m-d', $transaction_date)->toDateTimeString();

        $total_before_tax = 0;
        $location_id = $variations['opening_stock_location'];
        if (isset($variations['variations'][0]['opening_stock'])) {
            //Add opening stock transaction
            $transaction = Transaction::create(
                [
                                'type' => 'opening_stock',
                                'opening_stock_product_id' => $product->id,
                                'status' => 'received',
                                'business_id' => $business_id,
                                'transaction_date' => $transaction_date,
                                'total_before_tax' => $total_before_tax,
                                'location_id' => $location_id,
                                'final_total' => $total_before_tax,
                                'payment_status' => 'paid',
                                'created_by' => $user_id
                            ]
            );

            foreach ($variations['variations'] as $variation_os) {
                if (!empty($variation_os['opening_stock'])) {
                    $variation = Variation::where('product_id', $product->id)
                                    ->where('name', $variation_os['value'])
                                    ->first();
                    if (!empty($variation)) {
                        $opening_stock = [
                            'quantity' => $variation_os['opening_stock'],
                            'exp_date' => $variation_os['opening_stock_exp_date'],
                        ];

                        $total_before_tax = $total_before_tax + ($variation_os['opening_stock'] * $variation->dpp_inc_tax);
                    }

                    //Get product tax
                    $tax_percent = !empty($product->product_tax->amount) ? $product->product_tax->amount : 0;
                    $tax_id = !empty($product->product_tax->id) ? $product->product_tax->id : null;

                    $item_tax = $this->productUtil->calc_percentage($variation->default_purchase_price, $tax_percent);

                    //Create purchase line
                    $transaction->purchase_lines()->create([
                                    'product_id' => $product->id,
                                    'variation_id' => $variation->id,
                                    'quantity' => $opening_stock['quantity'],
                                    'item_tax' => $item_tax,
                                    'tax_id' => $tax_id,
                                    'purchase_price' => $variation->default_purchase_price,
                                    'purchase_price_inc_tax' => $variation->dpp_inc_tax,
                                    'exp_date' => !empty($opening_stock['exp_date']) ? $opening_stock['exp_date'] : null
                                ]);
                    //Update variation location details
                    $this->productUtil->updateProductQuantity($location_id, $product->id, $variation->id, $opening_stock['quantity']);
                }
            }

            $transaction->total_before_tax = $total_before_tax;
            $transaction->final_total = $total_before_tax;
            $transaction->save();
        }
    }

    private function rackDetails($rack_value, $row_value, $position_value, $business_id, $product_id, $row_no)
    {

        if (!empty($rack_value) || !empty($row_value) || !empty($position_value)) {
            $locations = BusinessLocation::forDropdown($business_id);
            $loc_count = count($locations);

            $racks = explode('|', $rack_value);
            $rows = explode('|', $row_value);
            $position = explode('|', $position_value);

            if (count($racks) > $loc_count) {
                $error_msg = "Invalid value for RACK in row no. $row_no";
                throw new \Exception($error_msg);
            }

            if (count($rows) > $loc_count) {
                $error_msg = "Invalid value for ROW in row no. $row_no";
                throw new \Exception($error_msg);
            }

            if (count($position) > $loc_count) {
                $error_msg = "Invalid value for POSITION in row no. $row_no";
                throw new \Exception($error_msg);
            }

            $rack_details = [];
            $counter = 0;
            foreach ($locations as $key => $value) {
                $rack_details[$key]['rack'] = isset($racks[$counter]) ? $racks[$counter] : '';
                $rack_details[$key]['row'] = isset($rows[$counter]) ? $rows[$counter] : '';
                $rack_details[$key]['position'] = isset($position[$counter]) ? $position[$counter] : '';
                $counter += 1;
            }

            if (!empty($rack_details)) {
                $this->productUtil->addRackDetails($business_id, $product_id, $rack_details);
            }
        }
    }
}
