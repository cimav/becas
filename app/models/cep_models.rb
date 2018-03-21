class CepModels < ActiveRecord::Base
  self.abstract_class = true
  establish_connection CEP_DB
end
