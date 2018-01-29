class Area < SaposModels
  has_one :staff

  NONE         = 0
  DIRECTION    = 1
  COORDINATION = 2
  DEPARTMENT   = 3

  TYPE = {
      NONE         => 'Elegir tipo de area',
      DIRECTION    => 'Dirección',
      COORDINATION => 'Coordinación',
      DEPARTMENT   => 'Departamento'
  }

  def type_type
    TYPE[type]
  end

end