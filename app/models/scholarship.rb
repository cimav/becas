class Scholarship < ApplicationRecord
  belongs_to :person, polymorphic: true
end
