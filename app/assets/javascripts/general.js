$(document).on('ready turbolinks:load', function() {
    $("tr.tr-click").on('click', function () {
        Turbolinks.visit($(this).attr("href"));
    });


    $('.button-collapse').sideNav({
        menuWidth: 80, // Default is 300
        edge: 'left', // Choose the horizontal origin
        closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
        draggable: true, // Choose whether you can drag to open on touch screens,
        onOpen: function(el) {}, // A function to be called when sideNav is opened
        onClose: function(el) {}, // A function to be called when sideNav is closed
        }
    );





});


function get_internship(internship_id){
    //alert(internship_id)
    var jqxhr = $.get( "/internship_data/"+internship_id, function() {
        })
        .done(function() {
            internship = jQuery.parseJSON(jqxhr.responseText);

            $('#scholarship_internship_type').val(internship.internship_type.name);
            Materialize.updateTextFields();
            console.log(internship.internship_type.name);
        })
        .fail(function() {
            Materialize.toast("No se pueden cargar los datos", 3000)
        })
        .always(function() {
        });

}