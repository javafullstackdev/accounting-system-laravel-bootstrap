@extends('layouts.app')
@section('title', __('home.home'))

@section('css')
@endsection

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>{{ __('home.welcome_message', ['name' => Session::get('user.first_name')]) }} </h1>
	<div class="row">
		<div class="col-md-12 col-xs-12">
			<div class="container">
				<div class="col-md-6"></div>
				<div class="col-md-6">
					<div class="col-md-12">
                        <div class="form-group">
                            {!! Form::label('statistics_date_range',__('report.date_range') .  ':') !!}
							<input type="text" class="daterange form-control" id="statistics_date_range", readonly/>
                        </div>
                    </div>
				</div>
			</div>
		</div>
	</div>
</section>
@if(auth()->user()->can('dashboard.data'))
<!-- Main content -->
<section class="content">
	<br>
	<div class="row">
		{{-- Sales --}}
		<div class="col-md-4 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-aqua">
					<i class="ion ion-ios-calculator"></i>
				</span>
				<div class="info-box-content">
					<span class="info-box-text">{{ __('home.sales') }}</span>
					<span class="info-box-number sales"><i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i></span>
				</div>
			</div>
		</div>
		{{-- Purchases --}}
    	<div class="col-md-4 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-blue-gradient">
					<i class="ion ion-ios-cart"></i>
				</span>
				<div class="info-box-content">
					<span class="info-box-text">{{ __('home.purchases') }}</span>
					<span class="info-box-number purchases"><i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i></span>
				</div>
			</div>
	    </div>
	  	{{-- Customer payments   --}}
	    <div class="col-md-4 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-purple-gradient">
					<i class="ion ion-cash"></i>
				</span>
				<div class="info-box-content">
					<span class="info-box-text">{{ __('home.customer_payments') }}</span>
					<span class="info-box-number customer_payments"><i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i></span>
				</div>
			</div>
		</div>
		{{-- Supplier payments	 --}}
		<div class="col-md-4 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-purple-active">
					<i class="ion ion-cash"></i>
				</span>

				<div class="info-box-content">
					<span class="info-box-text">{{ __('home.supplier_payments') }}</span>
					<span class="info-box-number supplier_payments"><i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i></span>
				</div>
			</div>
		</div>
		{{-- Expenses	 --}}
		<div class="col-md-4 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-red-active">
					<i class="ion ion-arrow-graph-down-right"></i>
				</span>
				<div class="info-box-content">
					<span class="info-box-text">{{ __('home.expenses') }}</span>
					<span class="info-box-number expenses"><i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i></span>
				</div>
			</div>
		</div>
		{{-- Sold Items Cost --}}
		<div class="col-md-4 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-light-green">
					<i class="ion ion-android-cart"></i>
				</span>
				<div class="info-box-content">
					<span class="info-box-text">{{ __('home.sold_items_cost') }}</span>
					<span class="info-box-number sold_items_cost"><i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i></span>
				</div>
			</div>
		</div>
		{{-- Profits of the sold items	 --}}
		<div class="col-md-4 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-green-active">
					<i class="ion ion-connection-bars"></i>
				</span>
				<div class="info-box-content">
					<span class="info-box-text">{{ __('home.profit_sold_items') }}</span>
					<span class="info-box-number profit_sold_items"><i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i></span>
				</div>
			</div>
		</div>
		{{-- Total cost of inventory	 --}}
		<div class="col-md-4 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-light-blue">
					<i class="ion ion-ios-home"></i>
				</span>

				<div class="info-box-content">
					<span class="info-box-text">{{ __('home.total_inventory_value') }}</span>
					<span class="info-box-number total_inventory_value"><i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i></span>
				</div>
			</div>
		</div>
		{{-- Total customer debts	 --}}
		<div class="col-md-4 col-sm-6 col-xs-12">
			<div class="info-box">
				<span class="info-box-icon bg-yellow">
					<i class="fa fa-dollar"></i>
					<i class="fa fa-exclamation"></i>
				</span>

				<div class="info-box-content">
					<span class="info-box-text">{{ __('home.total_customer_debts') }}</span>
					<span class="info-box-number total_customer_debts"><i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i></span>
				</div>
			</div>
		</div>
  	</div>
</section>
@stop

@section('javascript')
<script src="{{ asset('js/home.js?v=' . $asset_v) }}"></script>
@endif
@endsection

