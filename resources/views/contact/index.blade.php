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

@section('title', __('lang_v1.'.$type.'s'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1> @lang('lang_v1.'.$type.'s')
        <small>@lang( 'contact.manage_your_contact', ['contacts' =>  __('lang_v1.'.$type.'s') ])</small>
        @if($type == 'customer')
            <a class="btn pull-right bg-green btn-sm" href="{{action('RegularBalanceController@index', ['type' => $type])}}">
                <b><i class="fa fa-newspaper-o"></i></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;@lang('lang_v1.regular_balance')
            </a>
        @endif
        @if(auth()->user()->can('supplier.create') || auth()->user()->can('customer.create'))
            <a class="btn pull-right bg-light-blue btn-sm" href="{{action('ContactController@getStartingBalance', ['type' => $type])}}">
                <b><i class="fa fa-newspaper-o"></i></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;@lang('lang_v1.starting_balance')
            </a>
        @endif
    </h1>
</section>

<!-- Main content -->
<section class="content">

    <input type="hidden" value="{{$type}}" id="contact_type">

	<div class="box">
        <div class="box-header">
        	<h3 class="box-title">@lang( 'contact.all_your_contact', ['contacts' => __('lang_v1.'.$type.'s') ])</h3>
            @if(auth()->user()->can('supplier.create') || auth()->user()->can('customer.create'))
            	<div class="box-tools">
                    <button type="button" class="pull-right btn btn-sm btn-block btn-primary btn-modal"
                    data-href="{{action('ContactController@create', ['type' => $type])}}"
                    data-container=".contact_modal">
                    <i class="fa fa-plus"></i> @lang('messages.add')</button>
                </div>
            @endif
        </div>
        <div class="box-body">
            @if($type == 'customer')
                @if(auth()->user()->can('supplier.create') || auth()->user()->can('customer.create'))
                    <label class="switch show-hide-switch">
                        <input type="checkbox" id="nonZero">
                        <span class="slider"></span>
                    </label>
                @endif
            @endif

            @if(auth()->user()->can('supplier.view') || auth()->user()->can('customer.view'))
                <div class="table-responsive">
            	<table class="table table-bordered table-striped" id="contact_table">
            		<thead>
            			<tr>
                            <th>#</th>
                            <th>@lang('contact.name')</th>
                            <th>@lang('business.address')</th>
                            <th>@lang('contact.balance')</th>
                            <th>@lang('messages.action')</th>
            			</tr>
            		</thead>
            	</table>
                </div>
            @endif
        </div>
    </div>

    <div class="modal fade contact_modal" tabindex="-1" role="dialog" 
    	aria-labelledby="gridSystemModalLabel">
    </div>
    <div class="modal fade pay_contact_due_modal" tabindex="-1" role="dialog" 
        aria-labelledby="gridSystemModalLabel">
    </div>
</section>
<!-- /.content -->

@endsection
