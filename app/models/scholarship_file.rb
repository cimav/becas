class ScholarshipFile < ApplicationRecord
  mount_uploader :file, ScholarshipFileUploader
  after_destroy_commit :delete_file
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

  def delete_file
    remove_file!
  end

end
