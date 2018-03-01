class ScholarshipsMailer < ApplicationMailer
  def new_scholarship(scholarship, to)
    @scholarship = scholarship

    @from = "Notificaciones CIMAV <notificaciones@cimav.edu.mx>"
    @to = to
    mail(to: @to.email,  :from => @from, subject: "[BECAS] #{@scholarship.person.full_name}")
  end
end