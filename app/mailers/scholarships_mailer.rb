class ScholarshipsMailer < ApplicationMailer
  def notice_admin(scholarship, to)
    @scholarship = scholarship

    @from = "Notificaciones CIMAV <notificaciones@cimav.edu.mx>"
    @to = to
    mail(to: @to.email,  :from => @from, subject: "[BECAS] #{@scholarship.person.full_name}")
  end

  def notice_student(scholarship, to)
    @scholarship = scholarship

    @from = "Notificaciones CIMAV <notificaciones@cimav.edu.mx>"
    @to = to
    mail(to:" #{@scholarship.person.email}",  :from => @from, subject: "[BECAS] #{@scholarship.person.full_name}")
  end
end
