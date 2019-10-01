class Agreement < CepModels
  audited
  belongs_to :meeting
  belongs_to :agreeable, polymorphic: true
  after_create :set_id_key



  OPEN = 1
  CLOSE = 2
  DELETED = 5

  NOT_SENT = 1
  SENT = 2


  STATUS = {OPEN=>'Abierto', CLOSE=>'Cerrado', DELETED =>'Eliminado'}

  before_create do
    self.status = OPEN
  end

  def get_status
    STATUS[self.status]
  end

  def set_id_key
    # Asignar número consecutivo
    last_consecutive = Agreement.where(meeting_id: self.meeting_id).maximum("consecutive")
    if last_consecutive.nil?
      consecutive = 1
    else
      consecutive = last_consecutive + 1
    end

    # Asignar folio
    id_key = "#{self.meeting.id_key}/A#{sprintf '%03d', consecutive}"

    self.consecutive = consecutive
    self.id_key = id_key
    self.save
  end

  # obtener texto de la decisión tomada
  def get_decision
    Response::FINAL_DECISIONS[self.decision]
  end


end
