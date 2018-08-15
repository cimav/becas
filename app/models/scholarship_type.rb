class ScholarshipType < ApplicationRecord
  audited
  has_many :scholarships, dependent: :destroy
  before_create :set_status

  FISCAL = 1
  OWN_RESOURCES = 2

  # status
  ACTIVE = 1
  DELETED = 99

  CATEGORIES = {FISCAL=>'Fiscales', OWN_RESOURCES=>'Recursos propios'}

  def get_category
    CATEGORIES[self.category]
  end

  def set_status
    self.status = ACTIVE
  end

  def full_name
    "#{self.name} (#{self.category == FISCAL ? 'Fiscales':'Propios'})"
  end
end
