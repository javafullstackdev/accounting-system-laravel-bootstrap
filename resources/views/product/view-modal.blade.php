<div class="modal-dialog modal-xm" role="document">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close no-print" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title" id="modalTitle">{{$product->name}}</h4>
		</div>
		<div class="modal-body">
			<div class="row invoice-info">
				<div class="col-sm-3 invoice-col">
					<b>@lang('product.brand'): </b>
					{{$product->brand->name or '--' }}<br>
				</div>

				<div class="col-sm-3 invoice-col">
					<b>@lang('product.category'): </b>
					{{$product->category->name or '--' }}<br>

					<b>@lang('product.manage_stock'): </b>
					@if($product->enable_stock)
						@lang('messages.yes')
					@else
						@lang('messages.no')
					@endif
					<br>
					{{--@if($product->enable_stock)--}}
						{{--<b>@lang('product.alert_quantity'): </b>--}}
						{{--{{$product->alert_quantity or '--' }}--}}
					{{--@endif--}}
				</div>

				<div class="col-sm-3 invoice-col">
					<b>@lang('product.expires_in'): </b>
					@php
						$expiry_array = ['months'=>__('product.months'), 'days'=>__('product.days'), '' =>__('product.not_applicable') ];
					@endphp
					@if(!empty($product->expiry_period) && !empty($product->expiry_period_type))
						{{$product->expiry_period}} {{$expiry_array[$product->expiry_period_type]}}
					@else
						{{$expiry_array['']}}
					@endif

				</div>
				<div class="col-sm-3 col-md-3 invoice-col">
					@if(!empty($product->image))
						<div class="thumbnail">
							<img src="{{$image_url . $product->image }}" alt="Product image">
						</div>
					@else
						<div class="thumbnail">
							<img src="/img/default.png" alt="Product image">
						</div>
					@endif
				</div>
			</div>

			@if($product->type == 'single')
				@include('product.partials.single_product_details')
			@else
				@include('product.partials.variable_product_details')
			@endif
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default no-print" data-dismiss="modal">@lang( 'messages.close' )</button>
		</div>
	</div>
</div>

<script type="text/javascript">
    $(document).ready(function(){
        var element = $('div.modal-xl');
        __currency_convert_recursively(element);
    });
</script>
