class Scholarship < ApplicationRecord
  belongs_to :person, polymorphic: true
  belongs_to :scholarship_type

  before_create do
    self.status = REQUESTED
  end

  REQUESTED =   1
  APPROVED =   2
  REJECTED =   5
  DELETED =   99

  AMOUNTS = [1000,1500,2000]

  def get_amounts
  "$ #{AMOUNTS}"
  end

end
