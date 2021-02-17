<div class="modal-dialog modal-lg" role="document">
  <div class="modal-content">
  @php
    $form_id = 'regular_balance_add_form';
    if(isset($quick_add)){
    $form_id = 'quick_add_contact';
    }
  @endphp
    {!! Form::open(['url' => action('RegularBalanceController@store'), 'method' => 'post', 'id' => $form_id ]) !!}

    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title">@lang('contact.add_regular_balance')</h4>
    </div>

    <div class="modal-body">
      <div class="row">
          <div class="col-md-6">
              <div class="form-group">
                {!! Form::label('contact_id', __('contact.customer') . ':*' ) !!}
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                    {!! Form::select('contact_id', $customers, null , ['class' => 'form-control', 'id' => 'contact_id', 'style' => 'width:100%', 'placeholder' => __('messages.please_select'), 'required']); !!}
                </div>
              </div>
          </div>

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
          <div class="clearfix"></div>
          <div class="col-md-6">
              <div class="form-group">
                  {!! Form::label('amount', __('contact.amount') . ':*') !!}
                  <div class="input-group">
                        <span class="input-group-addon">
                            <i class="fa fa-money"></i>
                        </span>
                      {!! Form::text('amount', null, ['class' => 'form-control pos_quantity input_number valid select2-selection_rendered', 'required', 'aria-invalid' => 'false', 'placeholder' => 'Please insert positive number']); !!}
                  </div>
              </div>
          </div>

          <div class="col-md-6">
              <div class="form-group">
                  <div class="input-group">
                      {!! Form::label('additional_notes', __('contact.additional_notes') . ':') !!}
                      {!! Form::textarea('additional_notes', null, ['class' => 'form-control', 'placeholder' => __('contact.reason_for_regular_balance'), 'rows' => 3]); !!}
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
