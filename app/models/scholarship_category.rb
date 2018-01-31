# coding: utf-8
class ScholarshipCategory < SaposModels
  has_many :scholarship_types
  accepts_nested_attributes_for :scholarship_types
end
