class ScholarshipComment < ApplicationRecord
  belongs_to :scholarship
  belongs_to :person, polymorphic: true

  before_create :set_status

  ACTIVE = 1
  DELETED = 99

  def set_status
    self.status = ACTIVE
  end

end
