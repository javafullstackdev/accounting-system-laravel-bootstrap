$(document).ready(function() {
    var currency_table = $('#currency_table').DataTable({
        processing: true,
        serverSide: true,
        ajax: '/currencies',
        columnDefs: [ {
            "orderable": false,
            "searchable": false
        } ],
        columns: [
            {data: 'id', name: 'id'},
            {data: 'country', name: 'country'},
            {data: 'currency', name: 'currency'},
            {data: 'code', name: 'code'},
            {data: 'symbol', name: 'symbol'},
            {data: 'currency_rate', name: 'currency_rate'},
            {data: 'action', name: 'action'},
        ],
        "fnDrawCallback": function (oSettings) {
            __currency_convert_recursively($('#currency_table'));
        }
    });

    $('.currency_modal').on('shown.bs.modal', function (e) {

        $("form#currency_add_form, form#currency_edit_form").submit(function(e){
            e.preventDefault();
        }).validate({
            rules: {
                currency_rate: {
                    remote: {
                        url: "/currencies/check-currency",
                        type: "post",
                        data: {
                            currency_rate: function() {
                                return $( "#currency_rate" ).val();
                            }
                        }
                    }
                }
            },
            messages:{
                currency_rate: {
                    remote: LANG.currency_rate_valid
                }
            },
            submitHandler: function(form) {
                e.preventDefault();
                var data = $(form).serialize();

                $.ajax({
                    method: "POST",
                    url: $(form).attr("action"),
                    dataType: "json",
                    data: data,
                    success: function(result){
                        if(result.success == true){
                            $('div.currency_modal').modal('hide');
                            toastr.success(result.msg);
                            currency_table.ajax.reload();
                        } else {
                            toastr.error(result.msg);
                        }
                    }
                });
            }
        });
    });

    $(document).on('click', '.edit_currency_button', function(e){
        e.preventDefault();
        $( "div.currency_modal" ).load( $(this).attr('href'), function(){
            $(this).modal('show');
        });
    });

    $(document).on('click', '.delete_currency_button', function(e){
        e.preventDefault();
        swal({
            title: LANG.sure,
            text: LANG.confirm_delete_currency,
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then((willDelete) => {
            if (willDelete) {
                var href = $(this).attr('href');
                var data = $(this).serialize();

                $.ajax({
                    method: "DELETE",
                    url: href,
                    dataType: "json",
                    data: data,
                    success: function(result){
                        if(result.success == true){
                            toastr.success(result.msg);
                            currency_table.ajax.reload();
                        } else {
                            toastr.error(result.msg);
                        }
                    }
                });
            }
        });
    });
});