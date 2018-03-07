class ScholarshipToken < ApplicationRecord
  belongs_to :scholarship

  ACTIVE = 1
  INACTIVE = 2

end
