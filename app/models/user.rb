class User < ApplicationRecord
  has_many :scholarship_comments, as: :person

  ADMIN = 1
  VIEWER = 2
  SUPER_USER = 1000

  DELETED = 99

  USER_TYPES = {ADMIN=>'Administrador', VIEWER=>'Espectador'}

end
