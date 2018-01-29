class User < ApplicationRecord

  ADMIN = 1
  VIEWER = 2
  SUPER_USER = 1000

  USER_TYPE = {ADMIN:'Administrador', VIEWER:'Espectador'}

end
