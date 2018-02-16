class ScholarshipComment < ApplicationRecord
  belongs_to :scholarship
  belongs_to :person, polymorphic: true
end
