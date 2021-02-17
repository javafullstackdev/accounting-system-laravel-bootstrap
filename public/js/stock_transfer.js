$(document).ready( function () {
	//Add products
    if($( "#search_product_for_srock_adjustment" ).length > 0){
        //Add Product
		$( "#search_product_for_srock_adjustment" ).autocomplete({
			source: function(request, response) {
	    		$.getJSON("/products/list", { location_id: $('#location_id').val(), term: request.term }, response);
	  			},
			minLength: 2,
			response: function(event,ui) {
				if (ui.content.length == 1)
				{
					ui.item = ui.content[0];
					if(ui.item.qty_available > 0 && ui.item.enable_stock == 1){
						$(this).data('ui-autocomplete')._trigger('select', 'autocompleteselect', ui);
						$(this).autocomplete('close');
					}
				} else if (ui.content.length == 0)
		            {
		                swal(LANG.no_products_found)
		            }
			},
			focus: function( event, ui ) {
				if(ui.item.qty_available <= 0){
					return false;
				}
			},
			select: function( event, ui ) {
				if(ui.item.qty_available > 0){
					$(this).val(null);
	    			stock_transfer_product_row(ui.item.variation_id);
				} else{
					alert(LANG.out_of_stock);
				}
			}
		})
		.autocomplete( "instance" )._renderItem = function( ul, item ) {
			if(item.qty_available <= 0){
				
				var string = '<li class="ui-state-disabled">'+ item.name;
				if(item.type == 'variable'){
	        		string += '-' + item.variation;
	        	}
	        	string += ' (' + item.sub_sku + ') (Out of stock) </li>';
	            return $(string).appendTo(ul);
	        } else if(item.enable_stock != 1){
	        	return ul;
	        } 
	        else {
	        	var string =  "<div>" + item.name;
	        	if(item.type == 'variable'){
	        		string += '-' + item.variation;
	        	}
	        	string += ' (' + item.sub_sku + ') </div>';
	    		return $( "<li>" )
	        		.append(string)
	        		.appendTo( ul );
	        }
	    }
    }

    $('select#location_id').change(function(){
		// $('table#stock_adjustment_product_table tbody').html('');
        $('tr.product_row').remove();
		$('#product_row_count').val(0);

        $.ajax({
            method: "GET",
            url: "/stock-transfers/get_inventory_products",

            data: {location_id:  $('select#location_id').val()},
            dataType: "html",
            success: function(results){
                $('#available_product_list').html(results);
            }
        });

	});

    $('select#available_product_list').on('change', function() {
        var add_via_ajax = true;

        if($('#stock_adjustment_product_table tbody').find('tr').length){
            //Search for variation id in each row of pos table
            $('#stock_adjustment_product_table tbody').find('tr').each( function(){

                var purchase_lines_id = $(this).find('input#purchase_lines_id').val();

                if(purchase_lines_id == $('select#available_product_list').val()){
                    add_via_ajax = false;

                    //Increment product quantity
                    qty_element = $(this).find('.pos_quantity');
                    var qty = __read_number(qty_element);
                    __write_number(qty_element, qty + 1);
                    qty_element.change();
                }
            });
        } else {
            add_via_ajax = true;
        }

        if(add_via_ajax){
            var product_row = $('input#product_row_count').val();

            $.ajax({
                method: "GET",
                url: "/stock-transfers/get_product_for_transfer",

                data: { product_row: product_row, purchase_id: $('#available_product_list').val()},
                dataType: "json",
                success: function(result){
                    if (result.success) {
                        $('input#location_id').val($('select#select_location_id').val());

                        $('table#stock_adjustment_product_table tbody').append(result.html_content).find('input.pos_quantity');

                        $('input#product_row_count').val(parseInt(product_row) + 1);
                        var this_row = $('table#stock_adjustment_product_table tbody').find("tr").last();
                        this_row.find('input#purchase_lines_id').val($('select#available_product_list').val());
                        var quantity = this_row.find('input.pos_quantity').val();

                        var line_total = quantity * __read_number(this_row.find('input.product_unit_price'));

                        __write_number(this_row.find('input.product_line_total'), line_total, false, 2);
                        // update_table_row(this_row);
                        update_table_total();
                    }
                }
            });
        }
    });

    $(document).on( 'change', 'input.product_quantity', function(){
		update_table_row( $(this).closest('tr') );
	});
	$(document).on( 'change', 'input.product_unit_price', function(){
		update_table_row( $(this).closest('tr') );
	});

	$(document).on( 'click', '.remove_product_row', function(){
		swal({
          title: LANG.sure,
          icon: "warning",
          buttons: true,
          dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {
            	$(this).closest('tr').remove();
				update_table_total();
            }
        });
	});

	//Date picker
    $('#transaction_date').datepicker({
        autoclose: true,
        format:datepicker_date_format
    });

    jQuery.validator.addMethod("notEqual", function(value, element, param) {
	  return this.optional(element) || value != param;
	}, "Please select different location");

    $('form#stock_transfer_form').validate({
    	rules: {
		    transfer_location_id: { 
		    	notEqual: function(){
		    		return $('select#location_id').val();
		    	} 
		    }
		  }
    });

    $('table#stock_adjustment_product_table tbody').on('change', 'input.pos_quantity', function(){

        if($('form#stock_transfer_form').validate()) {
            $('form#stock_transfer_form').validate().element($(this));
        }
        update_table_row( $(this).closest('tr') );

    });

    $('#save_stock_transfer').click( function(e){
    	e.preventDefault();

    	if($('table#stock_adjustment_product_table tbody').find('.product_row').length <= 0){
			toastr.warning(LANG.no_products_added);
			return false;
		}
    	if($('form#stock_transfer_form').valid()){
    		$('form#stock_transfer_form').submit();
    	} else {
    		return false;
    	}
    });

    stock_transfer_table = $('#stock_transfer_table').DataTable({
		processing: true,
		serverSide: true,
		ajax: '/stock-transfers',
		columnDefs: [ {
			"targets": 7,
			"orderable": false,
			"searchable": false
		} ],
        aaSorting: [[0, 'desc'], [1, 'desc']],
		columns: [
            { data: 'transaction_date', name: 'transaction_date'  },
            {data: 'ref_no', name: 'ref_no'},
            { data: 'location_from', name: 'l1.name'},
            { data: 'location_to', name: 'l2.name'},
            { data: 'shipping_charges', name: 'shipping_charges'},
            { data: 'final_total', name: 'final_total'},
            { data: 'additional_notes', name: 'additional_notes'},
            { data: 'action', name: 'action'}
        ],
        "fnDrawCallback": function (oSettings) {
            __currency_convert_recursively($('#stock_transfer_table'));
        }
    });
    var detailRows = [];

    $('#stock_transfer_table tbody').on( 'click', '.view_stock_transfer', function () {
        var tr = $(this).closest('tr');
        var row = stock_transfer_table.row( tr );
        var idx = $.inArray( tr.attr('id'), detailRows );
 
        if ( row.child.isShown() ) {
            $(this).find('i').removeClass( 'fa-eye' ).addClass('fa-eye-slash');
            row.child.hide();
 
            // Remove from the 'open' array
            detailRows.splice( idx, 1 );
        }
        else {
            $(this).find('i').removeClass( 'fa-eye-slash' ).addClass('fa-eye');

            row.child( get_stock_transfer_details( row.data() ) ).show();
 
            // Add to the 'open' array
            if ( idx === -1 ) {
                detailRows.push( tr.attr('id') );
            }
        }
    } );

    // On each draw, loop over the `detailRows` array and show any child rows
    stock_transfer_table.on( 'draw', function () {
        $.each( detailRows, function ( i, id ) {
            $('#'+id+' .view_stock_transfer').trigger( 'click' );
        } );
    } );

    //Delete Stock Transfer
    $(document).on('click', 'button.delete_stock_transfer', function(){
    	swal({
          title: LANG.sure,
          icon: "warning",
          buttons: true,
          dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {
            	var href = $(this).data('href');
            	$.ajax({
					method: "DELETE",
					url: href,
					dataType: "json",
					success: function(result){
						if(result.success){
							toastr.success(result.msg);
							stock_transfer_table.ajax.reload();
						} else {
							toastr.error(result.msg);
						}
					}
				});
            }
        });
    });
});

function stock_transfer_product_row(variation_id){
	var row_index = parseInt($('#product_row_count').val());
	var location_id = $('select#location_id').val();
	$.ajax({
		method: "POST",
		url: "/stock-adjustments/get_product_row",
		data: {row_index: row_index, variation_id: variation_id, location_id: location_id},
		dataType: "html",
		success: function(result){
			$('table#stock_adjustment_product_table tbody').append(result);
			update_table_total();
			$('#product_row_count').val( row_index + 1);
		}
	});
}

function update_table_total(){
	var table_total = 0;
	$('table#stock_adjustment_product_table tbody tr').each( function(){
		var this_total = parseFloat(__read_number($(this).find('input.product_line_total')));
		if(this_total){
			table_total += this_total;
		}
	});
	$('input#total_amount').val(table_total);
	$('span#total_adjustment').text(__number_f(table_total));
}

function update_table_row( tr ){
	var quantity = parseFloat( __read_number(tr.find('input.pos_quantity')));
	var unit_price = parseFloat( __read_number(tr.find('input.product_unit_price')));
	var row_total = 0;
	if( quantity && unit_price){
		row_total = quantity * unit_price;
	}
	tr.find('input.product_line_total').val(__number_f(row_total));
	update_table_total();
}

function get_stock_transfer_details(rowData){
	var div = $('<div/>')
        .addClass( 'loading' )
        .text( 'Loading...' );
    $.ajax( {
        url: '/stock-transfers/' + rowData.DT_RowId,
        dataType: 'html',
        success: function ( data ) {
            div
                .html( data )
                .removeClass( 'loading' );
        }
    } );
 
    return div;
}