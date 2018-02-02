class ScholarshipType < ApplicationRecord
  has_many :scholarships

  CONACYT = 1
  INTERN = 2
  OWN_RESOURCES = 3

  CATEGORIES = {CONACYT:'Conacyt',INTERN:'Internas',OWN_RESOURCES:'Recursos propios'}

  def get_category
    CATEGORIES[self.category]
  end
end
