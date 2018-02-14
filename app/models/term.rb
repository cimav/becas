class Term < SaposModels
  has_many :term_courses
  has_many :term_students

  OPEN      = 1
  PROGRESS  = 2
  GRADING   = 3
  ENDED     = 4
  CANCELED  = 5

  STATUS = {OPEN     => 'Abierto',
            PROGRESS => 'En progreso',
            GRADING  => 'Calificando',
            ENDED    => 'Finalizado',
            CANCELED => 'Cancelado'}

  def status_type
    STATUS[status]
  end

end