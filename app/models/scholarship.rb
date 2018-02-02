class Scholarship < ApplicationRecord
  belongs_to :person, polymorphic: true
  belongs_to :scholarship_type

  before_create do
    self.status = REQUESTED
  end

  REQUESTED =   1
  APPROVED =   2
  REJECTED =   5
  DELETED =   99

  STATUS = {REQUESTED:'Solicitada',
            APPROVED: 'Aprobada',
            REJECTED: 'Rechazada',
            DELETED: 'Eliminada'
  }

  def get_amounts
  "$ #{AMOUNTS}"
  end

  def get_status
    STATUS[self.status]
  end

end
