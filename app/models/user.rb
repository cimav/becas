class User < ApplicationRecord
  has_many :scholarship_comments, as: :person
  before_create :set_status

  ADMIN = 1
  VIEWER = 2
  DEPARTMENT_ASSISTANT = 3
  SUPER_USER = 1000


  ACTIVE = 1
  DELETED = 99

  USER_TYPES = {ADMIN=>'Administrador', VIEWER=>'Espectador', DEPARTMENT_ASSISTANT=>'Asistente de departamento'}

  def set_status
    self.status = ACTIVE
  end

  def get_type
    USER_TYPES[self.user_type]
  end

end
