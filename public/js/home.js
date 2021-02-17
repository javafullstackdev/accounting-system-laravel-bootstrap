$(document).ready(function(){
    var start = new Date();
    var end = new Date();

    function convertDate(date) {
        var yyyy = date.getFullYear().toString();
        var mm = (date.getMonth()+1).toString();
        var dd  = date.getDate().toString();

        var mmChars = mm.split('');
        var ddChars = dd.split('');

        return yyyy + '-' + (mmChars[1]?mm:"0"+mmChars[0]) + '-' + (ddChars[1]?dd:"0"+ddChars[0]);
    }

    start = convertDate(start);
    end = convertDate(end);

    update_statistics(start, end);

	$('#statistics_date_range').daterangepicker({
        startDate: start,
        endDate: end,
        locale: {
            format: 'YYYY-MM-DD'
        }
	});


	$('#statistics_date_range').on('apply.daterangepicker', function(ev, picker) {
		$(this).val(picker.startDate.format('YYYY-MM-DD') + ' - ' + picker.endDate.format('YYYY-MM-DD'));
		var start = picker.startDate.format('YYYY-MM-DD');
		var end = picker.endDate.format('YYYY-MM-DD');
		update_statistics(start, end);
	});

	$('#statistics_date_range').on('cancel.daterangepicker', function(ev, picker) {
		$(this).val('');
	});

});

function update_statistics( start, end ){
	var data = { start: start, end: end };
	//get purchase details
	var loader = '<i class="fa fa-refresh fa-spin fa-fw margin-bottom"></i>';
	$('.sales').html(loader);
	$('.purchases').html(loader);
	$('.customer_payments').html(loader);
	$('.supplier_payments').html(loader);
	$('.expenses').html(loader);
	$('.sold_items_cost').html(loader);
	$('.profit_sold_items').html(loader);
	$('.total_inventory_value').html(loader);
	$('.total_customer_debts').html(loader);

	$.ajax({
		method: "POST",
		url: '/home/get-statistics-details',
		dataType: "json",
		data: data,
		success: function (data) {
			$('.sales').html(__currency_trans_from_en(data.sales, true ));
            $('.purchases').html(__currency_trans_from_en(data.purchases, true ));
			$('.customer_payments').html(__currency_trans_from_en(data.customer_payments, true));
            $('.supplier_payments').html(__currency_trans_from_en(data.supplier_payments, true));
            $('.expenses').html(__currency_trans_from_en(data.expenses, true));
            $('.sold_items_cost').html(__currency_trans_from_en(data.sold_items_cost, true));
            $('.profit_sold_items').html(__currency_trans_from_en(data.profit_sold_items, true));
            $('.total_inventory_value').html(__currency_trans_from_en(data.total_inventory_value, true));
            $('.total_customer_debts').html(__currency_trans_from_en(data.total_customer_debts, true));
		}
	});
}