class ScholarshipType < ApplicationRecord
  has_many :scholarships
  before_create :set_status

  CONACYT = 1
  FISCAL = 2
  OWN_RESOURCES = 3

  # status
  ACTIVE = 1
  DELETED = 99

  CATEGORIES = {CONACYT=>'CONACYT', FISCAL=>'Fiscales', OWN_RESOURCES=>'Recursos propios'}

  def get_category
    CATEGORIES[self.category]
  end

  def set_status
    self.status = ACTIVE
  end
end
