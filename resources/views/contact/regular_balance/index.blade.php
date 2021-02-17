@extends('layouts.app')
@section('title', __('lang_v1.regular_balance'))

@section('content')

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1> @lang('lang_v1.regular_balance')
            <small>@lang( 'lang_v1.manage_your_regular_balances')</small>
            @if(auth()->user()->can('supplier.create') || auth()->user()->can('customer.create'))
                @if($type == 'customer')
                <button type="button" class="btn pull-right btn-sm btn-primary btn-modal " data-href="{{action('RegularBalanceController@create', ['type' => $type])}}" data-container=".regular_balance_modal">
                    <b><i class="fa fa-plus"></i></b>&nbsp;&nbsp;&nbsp;@lang('contact.add_regular_balance')</button>
                @endif
            @endif
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <input type="hidden" value="{{$type}}" id="contact_type">
        <div class="box">
            <div class="box-body">
                @if(auth()->user()->can('supplier.view') || auth()->user()->can('customer.view'))
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped" id="regular_balance_table">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>@lang('contact.name')</th>
                                <th>@lang('lang_v1.date')</th>
                                <th>@lang('contact.amount')</th>
                                <th>@lang('messages.action')</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                @endif
            </div>
        </div>

        <div class="modal fade regular_balance_modal" tabindex="-1" role="dialog"
             aria-labelledby="gridSystemModalLabel">
        </div>
        {{--<div class="modal fade pay_contact_due_modal" tabindex="-1" role="dialog"--}}
             {{--aria-labelledby="gridSystemModalLabel">--}}
        {{--</div>--}}

    </section>
    <!-- /.content -->

@endsection