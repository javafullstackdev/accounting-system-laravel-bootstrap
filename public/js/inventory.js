$(document).ready(function() {
    var inventory_products_table = $('#inventory_products_table').DataTable({
        // processing: true,
        // serverSide: true,
        ajax: {
            url: '/inventory/' + $('#inventory_id').val(),
            data: function (d) {
                d.zeroQuantity = $('#zeroQuantity').is(':checked');
                d.expired = $('#expired').is(':checked');
            }
        },
        "fnDrawCallback": function (oSettings) {
            __currency_convert_recursively($('#inventory_products_table'));
        }
    });

    $('#zeroQuantity, #expired').on('change', function () {
        inventory_products_table.ajax.reload();
    });
});