class SaposModels < ActiveRecord::Base
  self.abstract_class = true
  establish_connection SAPOS_DB

  def self.db_name
    "sapos#{'_'+Rails.env}"
  end
end
