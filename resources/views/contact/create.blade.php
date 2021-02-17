<div class="modal-dialog modal-lg" role="document">
  <div class="modal-content">
  @php
    $form_id = 'contact_add_form';
    if(isset($quick_add)){
    $form_id = 'quick_add_contact';
    }
  @endphp
    {!! Form::open(['url' => action('ContactController@store'), 'method' => 'post', 'id' => $form_id ]) !!}

    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title">@lang('contact.add_contact')</h4>
    </div>

    <div class="modal-body">
      <div class="row">
      <div class="col-md-6 contact_type_div">
        <div class="form-group">
            {!! Form::label('type', __('contact.contact_type') . ':*' ) !!}
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-user"></i>
                </span>
                {!! Form::select('type', $types, null , ['class' => 'form-control', 'id' => 'contact_type','placeholder' => __('messages.please_select'), 'required']); !!}
            </div>
        </div>
      </div>
      <div class="col-md-6">
        <div class="form-group">
            {!! Form::label('name', __('contact.name') . ':*') !!}
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-user"></i>
                </span>
                {!! Form::text('name', null, ['class' => 'form-control','placeholder' => __('contact.name'), 'required']); !!}
            </div>
        </div>
      </div>
      <div class="clearfix"></div>
      <div class="col-md-4 supplier_fields">
          <div class="form-group">
              {!! Form::label('supplier_business_name', __('business.business_name') . ':*') !!}
              <div class="input-group">
            <span class="input-group-addon">
                <i class="fa fa-briefcase"></i>
            </span>
                  {!! Form::text('supplier_business_name', null, ['class' => 'form-control', 'required', 'placeholder' => __('business.business_name')]); !!}
              </div>
          </div>
      </div>
      <div class="clearfix"></div>
      <div class="col-md-3">
          <div class="form-group">
              {!! Form::label('mobile', __('contact.mobile') . ':*') !!}
              <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-mobile"></i>
                </span>
                  {!! Form::text('mobile', null, ['class' => 'form-control', 'required', 'placeholder' => __('contact.mobile')]); !!}
              </div>
          </div>
      </div>
      <div class="col-md-3">
          <div class="form-group">
              {!! Form::label('city', __('business.city') . ':*') !!}
              <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-map-marker"></i>
                </span>
                  {!! Form::text('city', null, ['class' => 'form-control', 'placeholder' => __('business.city'), 'required']); !!}
              </div>
          </div>
      </div>
      <div class="col-md-3">
          <div class="form-group">
              {!! Form::label('opening_balance', __('lang_v1.opening_balance') . ':') !!}
              <div class="input-group">
              <span class="input-group-addon">
                  <i class="fa fa-money"></i>
              </span>
              {!! Form::text('opening_balance', 0, ['class' => 'form-control input_number']); !!}
              </div>
          </div>
      </div>
      <div class="col-md-3">
        <div class="form-group">
            {!! Form::label('contact_person', __('lang_v1.contact_person') . ':') !!}
            <div class="input-group">
                <span class="input-group-addon">
                    <i class="fa fa-id-badge"></i>
                </span>
                {!! Form::text('contact_person', null, ['class' => 'form-control','placeholder' => __('lang_v1.contact_person')]); !!}
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