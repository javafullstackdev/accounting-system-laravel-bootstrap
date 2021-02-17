$(document).ready(function() {
    var bank_detail_table = $('#bank_detail_table').DataTable({
        processing: true,
        serverSide: true,
        ajax: {
            url: '/bank/' + $('#bank_id').val(),
            data: function (d) {
                d.bank_id = $('#bank_id').val();
            }
        },
        columnDefs: [{
            "orderable": false,
            "searchable": false
        }],
        "fnDrawCallback": function (oSettings) {
            __currency_convert_recursively($('#bank_detail_table'));
        }
    });

    $('.bank_payment_modal').on('shown.bs.modal', function (e) {

        $("form#add_bank_payment_form").submit(function(e){
            e.preventDefault();
        }).validate({
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
                            $('div.bank_payment_modal').modal('hide');
                            toastr.success(result.msg);
                            bank_detail_table.ajax.reload();
                        } else {
                            toastr.error(result.msg);
                        }
                    }
                });
            }
        });
    });

    $(document).on('click', '#receive_date', function () {
        $('#receive_date').datepicker({
            autoclose: true,
            format: "yyyy-mm-dd"
        });
    });
});