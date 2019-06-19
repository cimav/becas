function refreshInternshipFiles(scholarship_id){
    url = "/scholarships/"+scholarship_id+"/internship_files";
    $.get(url, function (data) {
        $('#internship_files').html(data);
    });
}


function refreshStudentFiles(scholarship_id){
    url = "/scholarships/"+scholarship_id+"/student_files";
    $.get(url, function (data) {
        $('#student_files').html(data);
    });
}

//-------------------------------------
// Respuesta al subir archivo por ajax
//-------------------------------------

$(document).on("ajax:success","#internship-files-form", function(ev,data){
        $('.modal').modal('close');
        refreshInternshipFiles(data.object.id); // se pasa el id de la beca
        Materialize.toast(data.message, 4000);
        // se puede acceder al objeto  por ejemplo data.object.id
});


$(document).on("ajax:error","#internship-files-form", function(ev,data){
    $('.modal').modal('close');
    Materialize.toast('Error al subir documento', 4000);
    for (i = 0; i<data.errors.length;i++) {
        Materialize.toast(data.errors[i], 4000);
    }
    // se puede acceder al objeto  por ejemplo data.object.id
});


function showInternshipFilesForm(file_type, file_name) {
    $('#upload_file_modal').modal('open');
    $('#internship_file_type').val(file_type);
    $('#internshipFileName').text(file_name);
}

$(document).on("ajax:success","#student-files-form", function(ev,data){
        $('.modal').modal('close');
        refreshStudentFiles(data.object.id); // se pasa el id de la beca
        Materialize.toast(data.message, 4000);
        // se puede acceder al objeto  por ejemplo data.object.id
});


$(document).on("ajax:error","#student-files-form", function(ev,data){
    $('.modal').modal('close');
    Materialize.toast('Error al subir documento', 4000);
    for (i = 0; i<data.errors.length;i++) {
        Materialize.toast(data.errors[i], 4000);
    }
    // se puede acceder al objeto  por ejemplo data.object.id
});


function showStudentFilesForm(file_type, file_name) {
    $('#upload_student_file_modal').modal('open');
    $('#student_file_type').val(file_type);
    $('#studentFileName').text(file_name);
}

function setScholarshipsHeight(){
    var screenHeight = window.innerHeight;
    var searchHeight = document.getElementById("scholarships-search-form").offsetHeight;
    document.getElementById("scholarships-wrapper").style.maxHeight = screenHeight-searchHeight-250 + "px";
}



//------------------------------------------------------------------------------
// Tabla de becas
//------------------------------------------------------------------------------
