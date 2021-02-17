<div class="modal-dialog" role="document">
  <div class="modal-content">

    {!! Form::open(['url' => action('BankController@update', [$bank->id]), 'method' => 'PUT', 'id' => 'bank_add_form' ]) !!}

    {!! Form::hidden('hidden_id', $bank->id, ['id' => 'hidden_id']); !!}
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <h4 class="modal-title">@lang( 'bank.edit_bank' )</h4>
    </div>

    <div class="modal-body">
      <div class="row">
        <div class="col-sm-12">
          <div class="form-group">
            {!! Form::label('name', __( 'bank.name' ) . ':*') !!}
              {!! Form::text('name', $bank->name, ['class' => 'form-control', 'required', 'placeholder' => __( 'bank.name' ) ]); !!}
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
</div><!-- /.modal-dialog -->