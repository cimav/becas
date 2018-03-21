class Internship < SaposModels
  belongs_to :institution
  belongs_to :staff
  belongs_to :internship_type
  belongs_to :area

  has_many :internship_files
  has_many :scholarships, as: :person

  ACTIVE    = 0
  FINISHED  = 1
  INACTIVE  = 2
  APPLICANT = 3

  STATUS = {ACTIVE    => 'Activo',
            FINISHED  => 'Finalizado',
            INACTIVE  => 'Inactivo',
            APPLICANT => 'Aspirante'}


  ACCEPTED   = 1
  REJECTED   = 2
  AUTHORIZED = 3
  INTERVIEW  = 4

  APPLICANT_STATUS = { ACTIVE    => 'Activo',
                       REJECTED  => 'Rechazado',
                       ACCEPTED  => 'Aceptado',
                       AUTHORIZED => 'Autorizado',
                       INTERVIEW  => 'Entrevista'
  }


  def full_name
    "#{first_name} #{last_name}" rescue ''
  end

end