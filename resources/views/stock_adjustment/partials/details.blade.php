<div class="row">
	<div class="col-xs-12 col-sm-10 col-sm-offset-1">
		<div class="table-responsive">
			<table class="table table-condensed bg-gray">
				<tr>
					<th>@lang('sale.product')</th>
					<th>@lang('sale.qty')</th>
					<th>@lang('sale.unit_price')</th>
					<th>@lang('sale.subtotal')</th>
					<th>@lang('product.exp_date')</th>
				</tr>
				@foreach( $stock_adjustment_details as $details )
					<tr>
						<td>
							{{ $details->product }} 
						</td>
						<td>
							{{@num_format($details->quantity)}}
						</td>
						<td>
							{{@num_format($details->unit_price)}}
						</td>
						<td>
							{{@num_format($details->unit_price * $details->quantity)}}
						</td>
						<td>
							<span>{{ $details->exp_date }}</span>
							{{--<div class="input-group">--}}
				                {{--<span class="input-group-addon">--}}
				                    {{--<i class="fa fa-calendar"></i>--}}
				                {{--</span>--}}
								{{--<input type="text" class="form-control input-sm expiry_datepicker" readonly value="{{ $details->exp_date }}">--}}
							{{--</div>--}}
						</td>
					</tr>
				@endforeach
			</table>
		</div>
	</div>
</div>