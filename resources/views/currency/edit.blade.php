<div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">

        {!! Form::open(['url' => action('CurrencyController@update', [$currency->id]), 'method' => 'PUT', 'id' => 'currency_edit_form']) !!}

        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">@lang('currencies.edit_currency')</h4>
        </div>

        <div class="modal-body">
            <div class="row">

                <div class="col-md-3">
                    <div class="form-group">
                        {!! Form::label('country', __('currencies.country') . ':' ) !!}
                        <div class="input-group">
                            {!! Form::text('country', $currency->country, ['class' => 'form-control', 'id' => 'country', 'readonly']); !!}
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        {!! Form::label('currency', __('currencies.currency') . ':' ) !!}
                        <div class="input-group">
                            {!! Form::text('currency', $currency->currency, ['class' => 'form-control', 'id' => 'currency', 'readonly']); !!}
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        {!! Form::label('code', __('currencies.code') . ':' ) !!}
                        <div class="input-group">
                            {!! Form::text('code', $currency->code, ['class' => 'form-control', 'id' => 'code', 'readonly']); !!}
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        {!! Form::label('currency_rate', __('currencies.rate') . ':*') !!}
                        <div class="input-group">
                        <span class="input-group-addon">
                            <i class="fa fa-money"></i>
                        </span>
                            {!! Form::text('currency_rate', $currency->currency_rate, ['class' => 'form-control input_number valid select2-selection_rendered', 'id' => 'currency_rate', $currency->country == 'United States of America' ? 'readonly' : '', 'aria-invalid' => 'false']); !!}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <button type="submit" class="btn btn-primary">@lang( 'messages.update' )</button>
            <button type="button" class="btn btn-default" data-dismiss="modal">@lang( 'messages.close' )</button>
        </div>

        {!! Form::close() !!}

    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
