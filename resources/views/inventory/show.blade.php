@extends('layouts.app')

@section('css')
    <style>
        .switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }

        /* Hide default HTML checkbox */
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        /* The slider */
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            -webkit-transition: .4s;
            transition: .4s;
        }

        input:checked + .slider {
            background-color: #2196F3;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(26px);
            -ms-transform: translateX(26px);
            transform: translateX(26px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

        .slider.round:before {
            border-radius: 50%;
        }
    </style>
@endsection
@section('title', __('inventory.view_inventory'))

@section('content')

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>{{ $inventory_name }}</h1>
        <input type="hidden" value="{{$inventory_id}}" id="inventory_id">
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="box">
            <div class="box-header">
                <h3 class="box-title">@lang( 'inventory.inventory_analysis' )</h3>
            </div>
            <div class="box-body">
                <label class="switch show-hide-switch">
                    <input type="checkbox" id="zeroQuantity">
                    <span class="slider"></span>
                </label>

                <label class="pull-right switch show-hide-switch">
                    <input type="checkbox" id="expired">
                    <span class="slider"></span>
                </label>

                @if(auth()->user()->can('supplier.view') || auth()->user()->can('customer.view'))
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped" id="inventory_products_table">
                            <thead>
                            <tr>
                                <th>@lang('inventory.product')</th>
                                <th>@lang('inventory.ref_number')</th>
                                <th>@lang('inventory.default_purchase_price')</th>
                                <th>@lang('inventory.quantity')</th>
                                <th>@lang('inventory.expire_date')</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                @endif
            </div>
        </div>

    </section>
    <!-- /.content -->

@endsection

@section('javascript')
    <script src="{{ asset('js/inventory.js?v=' . $asset_v) }}"></script>
@endsection
