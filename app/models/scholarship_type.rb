# coding: utf-8
class ScholarshipType < SaposModels
  has_many :scholarship
  belongs_to :scholarship_category
end
