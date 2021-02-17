@extends('layouts.app')
@section('title', __('sale.products'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>@lang('sale.products')
        <small>@lang('lang_v1.manage_products')</small>
        @can('product.create')
        <a class="btn pull-right bg-green btn-sm" href="{{action('ProductController@create')}}">
            <b><i class="fa fa-plus-circle"></i></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;@lang('product.add_new_product')
        </a>
        @endcan
    </h1>
</section>

<!-- Main content -->
<section class="content">
    <div class="row">
        <div class="col-md-12">
            <div class="box box-primary" id="accordion">
                <div class="box-header with-border">
                    <h3 class="box-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseFilter" aria-expanded="true">
                            <i class="fa fa-filter" aria-hidden="true"></i> @lang('report.filters')
                        </a>
                    </h3>
                </div>
                <div id="collapseFilter" class="panel-collapse active collapse in" aria-expanded="true">
                    <div class="box-body">
                        {!! Form::open(['url' => action('ProductController@index'), 'method' => 'get', 'id' => 'filter_form' ]) !!}
                        <div class="col-md-3">
                            <div class="form-group">
                                {!! Form::label('product_name', __('product.product_name') . ':') !!}
                                {!! Form::select('product_name', $productNames, null, ['placeholder' => __('messages.all'), 'class' => 'form-control select2', 'style' => 'width:100%', 'id' => 'product_name']); !!}
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                {!! Form::label('ref_number', __('product.ref_number') . ':') !!}
                                {!! Form::select('ref_number', $ref_numbers, null, ['placeholder' => __('messages.all'), 'class' => 'form-control select2', 'style' => 'width:100%', 'id' => 'ref_number']); !!}
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                {!! Form::label('brand_name', __('product.brand') . ':') !!}
                                {!! Form::select('brand_name', $brands, null, ['placeholder' => __('messages.all'), 'class' => 'form-control select2', 'style' => 'width:100%', 'id' => 'brand_name']); !!}
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                {!! Form::label('category_name', __('product.category') . ':') !!}
                                {!! Form::select('category_name', $categories, null, ['placeholder' => __('messages.all'), 'class' => 'form-control select2', 'style' => 'width:100%', 'id' => 'category_name']); !!}
                            </div>
                        </div>

                        {{--<div class="col-sm-12">--}}
                            {{--<button type="submit" class="btn btn-primary pull-right">@lang('report.apply_filters')</button>--}}
                        {{--</div>--}}
                        {!! Form::close() !!}
                    </div>
                </div>
            </div>
        </div>
    </div>

	<div class="box">
        <div class="box-body">
            @can('product.view')
                <div class="table-responsive">
                    <table class="table table-bordered table-striped ajax_view table-text-center" id="product_table">
                        <thead>
                        <tr>
                            {{--<th>#</th>--}}
                            <th>@lang('sale.product')</th>
                            <th>@lang('product.ref_number')</th>
                            <th>@lang('product.brand')</th>
                            <th>@lang('product.category')</th>
                            <th>@lang('product.purchase_price')</th>
                            <th>@lang('product.sell_price')</th>
                            <th>@lang('messages.action')</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            @endcan
        </div>
    </div>

    <input type="hidden" id="is_rack_enabled" value="{{$rack_enabled}}">

    <div class="modal fade product_modal" tabindex="-1" role="dialog" 
    	aria-labelledby="gridSystemModalLabel">
    </div>

    <div class="modal fade" id="view_product_modal" tabindex="-1" role="dialog" 
        aria-labelledby="gridSystemModalLabel">
    </div>

    <div class="modal fade" id="opening_stock_modal" tabindex="-1" role="dialog" 
        aria-labelledby="gridSystemModalLabel">
    </div>

</section>
<!-- /.content -->

@endsection

@section('javascript')
    <script src="{{ asset('js/product.js?v=' . $asset_v) }}"></script>
    <script src="{{ asset('js/opening_stock.js?v=' . $asset_v) }}"></script>
@endsection