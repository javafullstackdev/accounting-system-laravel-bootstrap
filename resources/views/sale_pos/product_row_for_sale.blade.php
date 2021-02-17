<tr class="product_row" data-row_index="{{$row_count}}">
	<td>
		{{--<span class="text-link text-info" title="@lang('lang_v1.pos_edit_product_price_help')" data-toggle="modal" data-target="#row_edit_product_price_modal_{{$row_count}}">--}}
		<span>
		{{$product->name}}
		</span>
		&nbsp;
		{{--<i class="fa fa-commenting cursor-pointer text-primary add-pos-row-description" title="@lang('lang_v1.add_description')" data-toggle="modal" data-target="#row_description_modal_{{$row_count}}"></i>--}}

		@if ($product->formatted_qty_available)
			@php
				$max_qty_rule = $product->formatted_qty_available;
				$max_qty_msg = __('validation.custom-messages.quantity_not_available', ['qty'=> $product->formatted_qty_available, 'unit' => $product->qty_available > 1.0 ? 'units' : 'unit'  ]);
			@endphp
		@else
			@php
				$max_qty_rule = $product->quantity;
				$max_qty_msg = __('validation.custom-messages.quantity_not_available', ['qty'=> $product->quantity, 'unit' => $product->quantity > 1.0 ? 'units' : 'unit'  ]);
			@endphp
		@endif
	</td>

	<td>
		{{-- If edit then transaction sell lines will be present --}}
		@if(!empty($product->transaction_sell_lines_id))
			<input type="hidden" name="products[{{$row_count}}][transaction_sell_lines_id]" class="form-control" value="{{$product->transaction_sell_lines_id}}">
		@endif

		<input type="hidden" name="products[{{$row_count}}][product_id]" class="form-control product_id" value="{{$product->product_id}}">
		<input type="hidden" name="products[{{$row_count}}][purchase_lines_id]" id="purchase_lines_id" value="{{ $product->id }}">
		<input type="hidden" value="{{$product->variation_id}}"
		       name="products[{{$row_count}}][variation_id]" class="row_variation_id">

		<input type="hidden" value="{{$product->enable_stock}}" name="products[{{$row_count}}][enable_stock]">

		@if(empty($product->quantity_ordered))
			@php
				$product->quantity_ordered = $product->quantity >= 1.0 ? 1 : $product->quantity;
			@endphp
		@else
			@php
				$product->quantity = $product->qty_available;
			@endphp
		@endif

		<div class="input-group input-number">
			<span class="input-group-btn"><button type="button" class="btn btn-default btn-flat quantity-down"><i class="fa fa-minus text-danger"></i></button></span>
			<input type="text" data-min="1" class="form-control pos_quantity input_number mousetrap" value="{{@num_format($product->quantity_ordered)}}" name="products[{{$row_count}}][quantity]"
			       data-decimal=1 data-rule-abs_digit="false"
			       data-rule-required="true" data-msg-required="@lang('validation.custom-messages.this_field_is_required')" @if($product->enable_stock) data-rule-max-value="{{$max_qty_rule}}" data-qty_available="{{$product->qty_available}}" data-msg-max-value="{{$max_qty_msg}}" data-msg_max_default="@lang('validation.custom-messages.quantity_not_available', ['qty'=> $product->quantity])" @endif>
			<span class="input-group-btn"><button type="button" class="btn btn-default btn-flat quantity-up"><i class="fa fa-plus text-success"></i></button></span>
		</div>
	</td>
	@php
		$unit_price_inc_tax = $product->dsp;
	@endphp
	<td class="hide">
		<input type="text" name="products[{{$row_count}}][unit_price_inc_tax]" class="form-control pos_unit_price_inc_tax input_number" value="{{@num_format($unit_price_inc_tax)}}">
	</td>
	<td>
		<input type="text"  class="form-control pos_unit_price_temp input_number mousetrap" value="{{@num_format($product->dsp)}}">
		<input type="hidden" name="products[{{$row_count}}][unit_price]" class="form-control pos_unit_price input_number mousetrap" value="{{@num_format($product->dsp)}}">
	</td>

	<td class="text-center v-center">
		<input type="hidden" name="products[{{$row_count}}][price]" class="form-control pos_line_total" value="{{@num_format($product->quantity_ordered*$product->dsp )}}">
		<span class="display_currency pos_line_total_text" id="pos_line_total_text" data-currency_symbol="true">{{$product->quantity_ordered * $product->dsp}}</span>
	</td>
	<td style="text-align: left;">
		<div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-calendar"></i>
                </span>
			<input type="text" name="products[{{ $row_count }}][exp_date]" class="form-control input-sm expiry_datepicker" readonly value="{{ $product->exp_date }}">
			{{--{!! Form::text('products[' . $row_count . '][exp_date]', null, ['class' => 'form-control input-sm expiry_datepicker', 'readonly']); !!}--}}
		</div>
	</td>
	<td class="text-center">
		<i class="fa fa-trash pos_remove_row cursor-pointer" aria-hidden="true"></i>
	</td>
</tr>
