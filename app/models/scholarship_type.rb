class UmasMaxAmount < ActiveModel::Validator
  def validate(record)
    if record.in_umas
        record.errors["UMA's"] << "Debe especificar un número máximo de UMA's" unless !record.umas_max_amount.blank?
    end
  end
end

class ScholarshipType < ApplicationRecord
  audited
  has_many :scholarships, dependent: :destroy
  before_create :set_status
  validates_with UmasMaxAmount


  # status
  ACTIVE = 1
  DELETED = 99


  def set_status
    self.status = ACTIVE
  end
end
