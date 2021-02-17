@extends('layouts.app')

@section('title', __('bank.view_bank'))

@section('content')

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            {{ $bank_name }}
            @if(auth()->user()->can('business_settings.access'))
                <button type="button" class="btn pull-right btn-sm btn-primary btn-modal " data-href="{{action('BankPaymentController@create', ['bank_id' => $bank_id])}}" data-container=".bank_payment_modal">
                    <b><i class="fa fa-plus"></i></b>&nbsp;&nbsp;&nbsp;@lang('bank.add_manual_payment')
                </button>
            @endif
        </h1>
        <input type="hidden" value="{{ $bank_id }}" id="bank_id">
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="box">
            <div class="box-body">
                @if(auth()->user()->can('supplier.view') || auth()->user()->can('customer.view'))
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped" id="bank_detail_table">
                            <thead>
                            <tr>
                                <th>@lang('bank.date')</th>
                                <th>@lang('bank.transaction_type')</th>
                                <th>@lang('bank.invoice_no')</th>
                                <th>@lang('bank.contact_name')</th>
                                <th>@lang('bank.receipts')</th>
                            </tr>
                            </thead>
                        </table>
                    </div>
                @endif
            </div>
        </div>

        <div class="modal fade bank_payment_modal" tabindex="-1" role="dialog"
             aria-labelledby="gridSystemModalLabel">
        </div>
    </section>
    <!-- /.content -->

@endsection

@section('javascript')
    <script src="{{ asset('js/bank.js?v=' . $asset_v) }}"></script>
@endsection
