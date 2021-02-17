<div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
        @php
            $form_id = 'add_bank_payment_form';
        @endphp
        {!! Form::open(['url' => action('BankPaymentController@store', ['bank_id' => $bank_id]), 'method' => 'post', 'id' => $form_id ]) !!}

        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">@lang('bank.add_bank_payment')</h4>
        </div>

        <div class="modal-body">
            <input type="hidden" value="{{ $bank_id }}" id="bank_id">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        {!! Form::label('receive_date', __('contact.receive_date') . ':*') !!}
                        <div class="input-group">
                        <span class="input-group-addon">
                            <i class="fa fa-calendar"></i>
                        </span>
                            {!! Form::text('receive_date', old('receive_date', Carbon\Carbon::today()->format('Y-m-d')), ['class' => 'form-control', 'id' => 'receive_date', 'readonly', 'required']); !!}
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        {!! Form::label('amount', __('bank.amount') . ':*') !!}
                        <div class="input-group">
                        <span class="input-group-addon">
                            <i class="fa fa-money"></i>
                        </span>
                            {!! Form::text('amount', null, ['class' => 'form-control input_number valid select2-selection_rendered', 'required', 'aria-invalid' => 'false', 'placeholder' => 'Please insert receipts']); !!}
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">@lang( 'messages.save' )</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">@lang( 'messages.close' )</button>
            </div>

            {!! Form::close() !!}

        </div><!-- /.modal-content -->
    </div>
</div><!-- /.modal-dialog -->
