class MaxAmountGreaterThanAmount < ActiveModel::Validator
  def validate(record)
    if record.amount
      unless record.max_amount >= record.amount
        record.errors[:amount] << 'no puede ser mayor al monto máximo'
      end
    end
  end
end

class Scholarship < ApplicationRecord
  belongs_to :person, polymorphic: true
  belongs_to :scholarship_type
  has_many :scholarship_comments

  validates :start_date, presence: true
  validates :amount, presence: true
  validates :end_date, presence: true
  validates :amount, numericality: true
  validates_with MaxAmountGreaterThanAmount

  before_create do
    self.status = REQUESTED
  end

  REQUESTED =   1
  APPROVED =   2
  ACTIVE =   3
  INACTIVE =   4
  REJECTED =   5
  DELETED =   99

  STATUS = {REQUESTED=>'Solicitada',
            APPROVED=> 'Aprobada',
            REJECTED=> 'Rechazada',
            ACTIVE=> 'Activa',
            INACTIVE=> 'Inactiva',
            DELETED=> 'Eliminada'
  }

  def get_status
    STATUS[self.status]
  end

  def send_new_scholarship_email_admin
    SendNewScholarshipEmailJob.perform_later(self.id,User.last.id)
  end
end
