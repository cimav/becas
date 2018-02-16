class Scholarship < ApplicationRecord
  belongs_to :person, polymorphic: true
  belongs_to :scholarship_type
  has_many :scholarship_comments

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

end
