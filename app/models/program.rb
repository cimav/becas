class Program < SaposModels
  has_many :students
  has_many :terms

  MASTER        = 1
  DOCTORATE     = 2
  PROPADEUTIC   = 3
  POSTDOCTORATE = 4
  DIPLOMA       = 5

  SEMESTER      = 1
  QUADMESTER    = 2
  TRIMESTER     = 3

  ALL                  = 0
  P_ACADEMICOS         = 2
  P_FORMACION_CONTINUA = 3
  P_PROPEDEUTICOS      = 4


  LEVEL = {POSTDOCTORATE => 'Postdoctorado',
           DOCTORATE     => 'Doctorado',
           MASTER        => 'Maestría',
           PROPADEUTIC   => 'Propedéutico',
           DIPLOMA       => 'Diplomado'}


  def level_type
    LEVEL[level]
  end

end