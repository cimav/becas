class ScholarshipFile < ApplicationRecord
  mount_uploader :file, ScholarshipFileUploader
  belongs_to :scholarship

  CEP_DOCUMENT = 1
  OTHER = 2

  TYPES = {
      CEP_DOCUMENT => 'Respuesta del CEP',
      OTHER => 'Otro'
  }

  def get_type
    TYPES[self.file_type]
  end

end
