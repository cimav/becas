function refreshInternshipFiles(scholarship_id){
    url = "/scholarships/"+scholarship_id+"/internship_files";
    $.get(url, function (data) {
        $('#internship_files').html(data);
    });
}