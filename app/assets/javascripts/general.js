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


    $('.modal').modal();


});

function get_student(){
    program = $('#scholarship_person_id option:selected').attr('data-student-program');
    curp= $('#scholarship_person_id option:selected').attr('data-curp');
    $('#scholarship_student_program').text(program);
    if(curp==null || curp.length<1){
        curp = "Sin capturar";
        $('#scholarship_curp').addClass('red-text');
    }else{
        $('#scholarship_curp').removeClass('red-text');
    }
    $('#scholarship_curp').text(curp);
    Materialize.updateTextFields();
}

function get_internship(){
    program = $('#scholarship_person_id option:selected').attr('data-internship-type');
    curp = $('#scholarship_person_id option:selected').attr('data-curp');
    if(curp==null || curp.length<1){
        curp = "Sin capturar";
        $('#scholarship_curp').addClass('red-text');
    }else{
        $('#scholarship_curp').removeClass('red-text');
    }
    $('#scholarship_internship_type').text(program);
    $('#scholarship_curp').text(curp);
    Materialize.updateTextFields();

}

function calculate_amount(){
    max_amount = $('#scholarship_scholarship_type_id option:selected').attr('data-amount');
    percent = $('#scholarship_percent').val();
    amount = max_amount*(percent/100);
    $('#scholarship_max_amount').text("$"+max_amount);
    $('#scholarship_amount').text("$"+amount.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,'));
}

function openModal(modal){
    modal.modal('open');
}