class User < ApplicationRecord

  ADMIN = 1
  VIEWER = 2
  SUPER_USER = 1000

  DELETED = 99

  USER_TYPES = {ADMIN:'Administrador', VIEWER:'Espectador'}

end
