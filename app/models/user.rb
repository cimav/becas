class User < ApplicationRecord
  has_many :scholarship_comments, as: :person
  has_many :admin_notes
  before_create :set_status
  serialize :areas, Array

  ADMIN = 1
  VIEWER = 2
  DEPARTMENT_ASSISTANT = 3
  DEPARTMENT_CHIEF = 4
  SUPER_USER = 1000


  ACTIVE = 1
  DELETED = 99

  USER_TYPES = {ADMIN=>'Administrador', VIEWER=>'Espectador', DEPARTMENT_ASSISTANT=>'Asistente de departamento', DEPARTMENT_CHIEF => 'Jefe de departamento'}


  def set_status
    self.status = ACTIVE
  end

  def get_type
    USER_TYPES[self.user_type]
  end

  def get_user_areas
    areas = ''
    self.areas.each do |area|
      areas+= " #{Area.find(area).name},"
    end
    areas.chop
  end

end
