@extends('layouts.app')
@section('title', __('inventory.inventories'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>@lang( 'inventory.inventories' )
        <small>@lang( 'inventory.manage_your_inventories' )</small>
    </h1>
</section>

<!-- Main content -->
<section class="content">

	<div class="box">
        <div class="box-header">
        	<h3 class="box-title">@lang( 'inventory.all_your_inventories' )</h3>
        	<div class="box-tools">
                <button type="button" class="btn btn-block btn-primary btn-modal" 
                	data-href="{{action('BusinessLocationController@create')}}" 
                	data-container=".location_add_modal">
                	<i class="fa fa-plus"></i> @lang( 'messages.add' )</button>
            </div>
        </div>

        <div class="box-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="business_location_table">
                    <thead>
                        <tr>
                            <th>@lang( 'invoice.name' )</th>
                            <th>@lang( 'inventory.address' )</th>
                            <th>@lang( 'messages.action' )</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

    <div class="modal fade location_add_modal" tabindex="-1" role="dialog" 
    	aria-labelledby="gridSystemModalLabel">
    </div>
    <div class="modal fade location_edit_modal" tabindex="-1" role="dialog" 
        aria-labelledby="gridSystemModalLabel">
    </div>

</section>
<!-- /.content -->

@endsection
