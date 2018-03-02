class NetmultixModels < ActiveRecord::Base
  self.abstract_class = true
  establish_connection NETMULTIX_DB
end
