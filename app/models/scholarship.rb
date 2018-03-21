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
  has_one :scholarship_token

  has_one :agreement, as: :agreeable, dependent: :destroy

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

  def notice_admin
    User.where(user_type: User::ADMIN).each do |user|
      ScholarshipNoticeAdminJob.perform_later(self.id, user.id)
    end
  end

  def notice_student
    ScholarshipNoticeStudentJob.perform_later(self.id, self.person_id, self.person_type)
  end

end
