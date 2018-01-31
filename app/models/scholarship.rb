class Scholarship < ApplicationRecord
  belongs_to :person, polymorphic: true

  AMOUNTS = [1000,1500,2000]

  def get_amounts
  "$ #{AMOUNTS}"
  end

end
