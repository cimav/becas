class MaxAmountGreaterThanAmount < ActiveModel::Validator
  def validate(record)
    if record.amount
      record.errors[:amount] << 'no puede ser mayor al monto máximo' unless record.max_amount >= record.amount
    end
  end
end

class Scholarship < ApplicationRecord
  audited
  belongs_to :person, polymorphic: true
  belongs_to :scholarship_type
  has_many :scholarship_comments, dependent: :destroy
  has_many :admin_notes, dependent: :destroy
  has_one :scholarship_token, dependent: :destroy
  has_many :scholarship_files, dependent: :destroy

  has_one :agreement, as: :agreeable, dependent: :destroy

  validates :start_date, presence: true
  validates :amount, presence: true
  validates :end_date, presence: true
  validates :category, presence: true
  validates :amount, numericality: true
  validates_with MaxAmountGreaterThanAmount

  before_create do
    self.status = REQUESTED
  end

  FISCAL = 1
  OWN_RESOURCES = 2

  REQUESTED =   1
  APPROVED =   2
  ACTIVE =   3
  INACTIVE =   4
  REJECTED =   5
  TO_COMMITTEE =   6
  CANCELED = 7
  DELETED =   99

  STATUS = {REQUESTED=>'Solicitada',
            APPROVED=> 'Aprobada',
            REJECTED=> 'Rechazada',
            ACTIVE=> 'Activa',
            INACTIVE=> 'Inactiva',
            TO_COMMITTEE=> 'Enviado a comité',
            CANCELED=> 'Cancelada',
            DELETED=> 'Eliminada'
  }

  CATEGORIES = {
      FISCAL => 'Recursos fiscales',
      OWN_RESOURCES => 'Recursos propios'
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

  def get_category
    CATEGORIES[self.category]
  end
end
