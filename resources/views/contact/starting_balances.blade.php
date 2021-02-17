@extends('layouts.app')
@section('title', __('lang_v1.starting_balance'))

@section('content')

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1> @lang('lang_v1.starting_balance')
            <small>@lang( 'lang_v1.manage_your_starting_balances')</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">
        <input type="hidden" value="{{$type}}" id="contact_type">
        <div class="box">
            <div class="box-body">
                @if(auth()->user()->can('supplier.view') || auth()->user()->can('customer.view'))
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped" id="starting_balance_table">
                            <thead>
                            <tr>
                                <th>#</th>
                                <th>@lang('contact.name')</th>
                                <th>@lang('lang_v1.date')</th>
                                <th>@lang('lang_v1.opening_balance')</th>
                                {{--<th>@lang('messages.action')</th>--}}
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
