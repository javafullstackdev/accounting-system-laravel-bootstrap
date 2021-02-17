@extends('layouts.app')
@section('title', __('currencies.currency'))

@section('content')

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1> @lang('currencies.currency')
            <small>@lang( 'currencies.manage_your_currency', ['currencies' =>  __('currencies.currency') ])</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">

        <div class="box">
            <div class="box-header">
                <h3 class="box-title">@lang( 'currencies.all_your_currencies', ['currencies' => __('currencies.currency') ])</h3>
                {{--<div class="box-tools">--}}
                    {{--<button type="button" class="btn btn-block btn-primary btn-modal"--}}
                            {{--data-href="{{action('CurrencyController@create')}}"--}}
                            {{--data-container=".currency_modal">--}}
                        {{--<i class="fa fa-plus"></i> @lang('messages.add')</button>--}}
                {{--</div>--}}
            </div>
            <div class="box-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped" id="currency_table">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>@lang('currencies.country')</th>
                            <th>@lang('currencies.currency_name')</th>
                            <th>@lang('currencies.code')</th>
                            <th>@lang('currencies.symbol')</th>
                            <th>@lang('currencies.rate')</th>
                            <th>@lang('messages.action')</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>

        <div class="modal fade currency_modal" tabindex="-1" role="dialog"
             aria-labelledby="gridSystemModalLabel">
        </div>

    </section>
    <!-- /.content -->

@endsection

@section('javascript')
    <script src="{{ asset('js/currency.js') }}"></script>
@endsection