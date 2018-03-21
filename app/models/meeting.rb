class Meeting < CepModels
  audited
  has_many :agreement, dependent: :destroy
  after_create :set_id_key

  ORDINARY = 1
  EXTRAORDINARY = 2

  MEETING_TYPES = {ORDINARY => 'Ordinaria', EXTRAORDINARY => 'Extraordinaria'}

  OPENED = 1
  CLOSED = 2
  DELETED = 5

  MEETING_STATUS = {OPENED => 'Abierta', CLOSED => 'Cerrada', DELETED => 'Eliminada'}

  def get_type
    MEETING_TYPES[self.meeting_type]
  end

  def get_status
    MEETING_STATUS[self.status]
  end

  def get_datetime_split(dateORTime)
    date = self.date
    if dateOrTime == 1
      date.split(" ")[0].to_date
    end
  end

  def set_id_key

    # Agregar número consecutivo
    meeting_year = self.date.strftime("%Y")
    last_consecutive = Meeting.where('extract(year from date) = ?', meeting_year).maximum("consecutive")
    if last_consecutive.nil?
      consecutive = 1
    else
      consecutive = last_consecutive + 1
    end

    # Asignar folio
    if self.meeting_type.eql? ORDINARY
      id_key = "S#{self.date.strftime("%y")}#{sprintf '%02d', consecutive}"
    else
      id_key = "SX#{self.date.strftime("%y")}#{sprintf '%02d', consecutive}"
    end

    self.consecutive = consecutive
    self.id_key = id_key
    self.save
  end

end
