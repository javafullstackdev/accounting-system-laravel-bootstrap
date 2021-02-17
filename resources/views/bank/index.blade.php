@extends('layouts.app')
@section('title', __('bank.banks'))

@section('content')

    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>@lang( 'bank.banks' )
            <small>@lang( 'bank.manage_your_banks' )</small>
        </h1>
    </section>

    <!-- Main content -->
    <section class="content">

        <div class="box">
            <div class="box-header">
                <h3 class="box-title">@lang( 'bank.all_your_banks' )</h3>
                <div class="box-tools">
                    <button type="button" class="btn btn-block btn-primary btn-modal"
                            data-href="{{action('BankController@create')}}"
                            data-container=".bank_add_modal">
                        <i class="fa fa-plus"></i> @lang( 'messages.add' )</button>
                </div>
            </div>

            <div class="box-body">
                <div class="table-responsive">
                    <table class="table table-bordered table-striped" id="bank_list_table">
                        <thead>
                        <tr>
                            <th>@lang( 'bank.name' )</th>
                            <th>@lang( 'bank.balance' )</th>
                            <th>@lang( 'messages.action' )</th>
                        </tr>
                        </thead>
                    </table>
                </div>
            </div>
        </div>

        <div class="modal fade bank_add_modal" tabindex="-1" role="dialog"
             aria-labelledby="gridSystemModalLabel">
        </div>
        <div class="modal fade bank_edit_modal" tabindex="-1" role="dialog"
             aria-labelledby="gridSystemModalLabel">
        </div>

    </section>
    <!-- /.content -->

@endsection
