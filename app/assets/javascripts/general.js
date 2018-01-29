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
