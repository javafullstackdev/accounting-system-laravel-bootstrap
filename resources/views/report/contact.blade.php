@extends('layouts.app')
@section('title', __('report.reports'))

@section('content')

<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>{{ __('report.customer')}} & {{ __('report.supplier')}} {{ __('report.reports')}}</h1>
    <!-- <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
    </ol> -->
</section>

<!-- Main content -->
<section class="content">

	<div class="box">

        <div class="box-body">
			<div class="row">
				<div class="col-sm-12">
					<div class="form-group">
						<div class="input-group">
							<button type="button" class="btn btn-primary" id="daterange-btn">
                                <span>
                                  <i class="fa fa-calendar"></i> {{ __('messages.filter_by_date') }}
                                </span>
								<i class="fa fa-caret-down"></i>
							</button>
						</div>
					</div>
				</div>
			</div>
            <div class="table-responsive">
        	<table class="table table-bordered table-striped" id="supplier_report_tbl">
        		<thead>
        			<tr>
        				<th>@lang('report.contact')</th>
        				<th>@lang('report.total_purchase')</th>
        				<th>@lang('report.total_sell')</th>
                        <th>@lang('report.balance') &nbsp;&nbsp;<i class="fa fa-info-circle text-info" data-toggle="tooltip" data-placement="bottom" data-html="true" data-original-title="{{ __('messages.due_tooltip')}}" aria-hidden="true"></i></th>
        			</tr>
        		</thead>
        	</table>
            </div>
        </div>
    </div>

</section>
<!-- /.content -->

@endsection

@section('javascript')
    <script src="{{ asset('js/report.js?v=' . $asset_v) }}"></script>
	<script>
        //Date range as a button
        $('#daterange-btn').daterangepicker(
            dateRangeSettings,
            function (start, end) {
                $('#daterange-btn span').html(start.format(moment_date_format) + ' ~ ' + end.format(moment_date_format));
                supplier_report_tbl.ajax.url( '/reports/customer-supplier?start_date=' + start.format('YYYY-MM-DD') +
                    '&end_date=' + end.format('YYYY-MM-DD') ).load();
            }
        );
        $('#daterange-btn').on('cancel.daterangepicker', function(ev, picker) {
            supplier_report_tbl.ajax.url( '/reports/customer-supplier').load();
            $('#daterange-btn span').html('<i class="fa fa-calendar"></i> {{ __("messages.filter_by_date") }}');
        });
	</script>
@endsection