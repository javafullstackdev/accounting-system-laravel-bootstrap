<style type="text/css" media="print">
	@page
	{
		size: auto;   /* auto is the initial value */
		margin-top: 2mm;  /* this affects the margin in the printer settings */
		margin-bottom: 2mm;
		margin-left: 5mm;
		margin-right: 5mm;
	}
</style>

<!-- business information here -->
<div class="row">

	<!-- Logo -->
	@if(!empty($receipt_details->logo))
		{{--<img style="width: 100%; height:150px;" src="{{$receipt_details->logo}}" class="img img-responsive center-block">--}}
		<img src="{{ $receipt_details->logo }}" alt="Logo">
	@endif

	<!-- Header text -->
	@if(!empty($receipt_details->header_text))
		<div class="col-xs-12 hide">
			{!! $receipt_details->header_text !!}
		</div>
	@endif

	<!-- business information here -->
	<div class="col-xs-12 text-center">
		<h4 class="text-center">
			<!-- Shop & Location Name  -->
			@if(!empty($receipt_details->display_name))
				{{$receipt_details->display_name}}
			@endif
		</h4>

		<!-- Address -->
		<p>
		@if(!empty($receipt_details->address))
			<small class="text-center">
				{!! $receipt_details->address !!}
			</small>
		@endif
		@if(!empty($receipt_details->contact))
			{{--<br/>{{ $receipt_details->contact }}--}}
			{{ $receipt_details->contact }}
		@endif	
		{{--@if(!empty($receipt_details->contact) && !empty($receipt_details->website))--}}
			{{--, --}}
		{{--@endif--}}
		{{--@if(!empty($receipt_details->website))--}}
			{{--{{ $receipt_details->website }}--}}
		{{--@endif--}}
		{{--@if(!empty($receipt_details->location_custom_fields))--}}
			{{--<br>{{ $receipt_details->location_custom_fields }}--}}
		{{--@endif--}}
		</p>

		<!-- Title of receipt -->
		@if(!empty($receipt_details->invoice_heading))
			<h3 class="text-center hide">
				{!! $receipt_details->invoice_heading !!}
			</h3>
		@endif

		<!-- Invoice  number, Date  -->
		<p style="width: 100% !important" >
			<span class="pull-left text-left word-wrap">
				@if(!empty($receipt_details->invoice_no_prefix))
					<b>{!! $receipt_details->invoice_no_prefix !!}</b>
				@endif
				{{$receipt_details->invoice_no}} &nbsp;&nbsp;&nbsp;&nbsp;
				@if(!empty($receipt_details->date_label))
					<b>{{$receipt_details->date_label}}</b>
				@endif
				{{ $receipt_details->invoice_date }} &nbsp;
					<br>
				<!-- customer info -->
				@if(!empty($receipt_details->customer_info))
					<b>{{ $receipt_details->customer_label }}</b>
				@endif
				{{ $receipt_details->customer_info }}

			</span>
		</p>
	</div>
	<!-- /.col -->
</div>
<br>
<div class="row">
	<div class="col-xs-12">
		<table class="table table-responsive">
			<thead>
				<tr>
					<th>{{$receipt_details->table_product_label}}</th>
					<th>{{$receipt_details->table_qty_label}}</th>
					<th>{{$receipt_details->table_unit_price_label}}</th>
					<th>{{$receipt_details->table_subtotal_label}}</th>
					<th>@lang('lang_v1.expiry_date')</th>
				</tr>
			</thead>
			<tbody>
			@php
				$idx = -1;
			@endphp
			@foreach($receipt_details->lines as $line)
				<tr>
					@php
						$idx++;
					@endphp
						<td>
							{{$line['name']}}
						</td>
						{{--<td>--}}
                            {{--{{$line['name']}} {{$line['variation']}} --}}
                            {{--@if(!empty($line['sub_sku'])), {{$line['sub_sku']}} @endif @if(!empty($line['brand'])), {{$line['brand']}} @endif @if(!empty($line['cat_code'])), {{$line['cat_code']}}@endif--}}
                            {{--@if(!empty($line['sell_line_note']))({{$line['sell_line_note']}}) @endif --}}
                            {{--@if(!empty($line['lot_number']))<br> {{$line['lot_number_label']}}:  {{$line['lot_number']}} @endif --}}
                            {{--@if(!empty($line['product_expiry'])), {{$line['product_expiry_label']}}:  {{$line['product_expiry']}} @endif --}}
                        {{--</td>--}}
						<td>{{$line['quantity']}} {{$line['units']}} </td>
						<td>$ {{$line['unit_price_inc_tax']}}</td>
						<td>$ {{$line['line_total']}}</td>
						<td>
							@if(!empty($exp_dates[$idx]->exp_date))
								{{ @format_date($exp_dates[$idx]->exp_date) }}
							@endif
						</td>
					</tr>
					@if(!empty($line['modifiers']))
						@foreach($line['modifiers'] as $modifier)
							<tr>
								<td>
		                            {{$modifier['name']}} {{$modifier['variation']}} 
		                            @if(!empty($modifier['sub_sku'])), {{$modifier['sub_sku']}} @endif @if(!empty($modifier['cat_code'])), {{$modifier['cat_code']}}@endif
		                            @if(!empty($modifier['sell_line_note']))({{$modifier['sell_line_note']}}) @endif 
		                        </td>
								<td>{{$modifier['quantity']}} {{$modifier['units']}} </td>
								<td>{{$modifier['unit_price_inc_tax']}}</td>
								<td>{{$modifier['line_total']}}</td>
							</tr>
						@endforeach
					@endif
			@endforeach
			</tbody>
		</table>
	</div>
</div>
<hr>
<div class="row">
	<div class="col-xs-4">

		<table class="table table-condensed">

			@if(!empty($receipt_details->payments))
				@foreach($receipt_details->payments as $payment)
					<tr class="hide">
						<td>{{$payment['method']}}</td>
						<td>{{$payment['amount']}}</td>
						<td>{{$payment['date']}}</td>
					</tr>
				@endforeach
			@endif
			<tr>
				<th style="width:40%">
					{!! $receipt_details->subtotal_label !!}
				</th>
				<td class="text-left">
					$ {{$receipt_details->subtotal}}
				</td>
			</tr>

		</table>

		{{$receipt_details->additional_notes}}
	</div>

	<div class="col-xs-4">

		<table class="table table-condensed">
			<!-- Total -->
			<tr>
				<th style="width:30%">
					{!! $receipt_details->total_label !!}
				</th>
				<td class="text-left">
					$ {{$receipt_details->total}}
				</td>
			</tr>
		</table>
	</div>

	<div class="col-xs-4">
        <div class="table-responsive">
          	<table class="table table-condensed">
				<tbody>
					<tr>
						<th style="width:30%">
							@lang('lang_v1.old_loan'):
						</th>
						<td class="text-left">
							$ {{ $old_loan }}
						</td>
					</tr>

					<!-- Grand Total -->
					<tr>
						<th style="width: 40%; background-color: #357ca5 !important; color: white !important" class="padding-10">
							@lang('lang_v1.grand_total')
						</th>
						<td class="text-left  padding-10" style="background-color: #357ca5 !important; color: white !important">
							$ {{ $customer_balance }}
						</td>
					</tr>

					<!-- Shipping Charges -->
					@if(!empty($receipt_details->shipping_charges))
						<tr>
							<th style="width:70%">
								{!! $receipt_details->shipping_charges_label !!}
							</th>
							<td>
								{{$receipt_details->shipping_charges}}
							</td>
						</tr>
					@endif

					<!-- Discount -->
					@if( !empty($receipt_details->discount) )
						<tr class="hide">
							<th>
								{!! $receipt_details->discount_label !!}
							</th>

							<td>
								(-) {{$receipt_details->discount}}
							</td>
						</tr>
					@endif

					<!-- Total Paid-->
					@if(!empty($receipt_details->total_paid))
						<tr class="hide">
							<th>
								{!! $receipt_details->total_paid_label !!}
							</th>
							<td>
								{{$receipt_details->total_paid}}
							</td>
						</tr>
					@endif
					<!-- Tax -->
					@if( !empty($receipt_details->tax) )
						<tr>
							<th>
								{!! $receipt_details->tax_label !!}
							</th>
							<td>
								(+) {{$receipt_details->tax}}
							</td>
						</tr>
					@endif


				</tbody>
        	</table>
        </div>
    </div>
</div>

@if($receipt_details->show_barcode)
	<div class="row">
		<div class="col-xs-12">
			{{-- Barcode --}}
			<img class="center-block" src="data:image/png;base64,{{DNS1D::getBarcodePNG($receipt_details->invoice_no, 'C128', 2,30,array(39, 48, 54), true)}}">
		</div>
	</div>
@endif

@if(!empty($receipt_details->footer_text))
	<div class="row">
		<div class="col-xs-12">
			{!! $receipt_details->footer_text !!}
		</div>
	</div>
@endif