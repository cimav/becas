function refreshInternshipFiles(scholarship_id){
    url = "/scholarships/"+scholarship_id+"/internship_files";
    $.get(url, function (data) {
        $('#internship_files').html(data);
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

