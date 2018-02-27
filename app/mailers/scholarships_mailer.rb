class ScholarshipsMailer < ApplicationMailer
  def new_scholarship(scholarship, send_to)
    @scholarship = scholarship

    @from = "Notificaciones CIMAV <notificaciones@cimav.edu.mx>"
    @to = send_to.map(&:email).join(",")
    mail(to: @to,  :from => @from, subject: "[BECAS] #{@scholarship.person.full_name}")
  end
end