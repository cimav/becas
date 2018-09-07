class ScholarshipFile < ApplicationRecord
  mount_uploader :file, ScholarshipFileUploader
  after_destroy_commit :delete_file
  belongs_to :scholarship

  CEP_DOCUMENT = 1
  NETMULTIX_DOCUMENT = 2
  OTHER = 50

  TYPES = {
      CEP_DOCUMENT => 'Respuesta del CEP',
      NETMULTIX_DOCUMENT => 'Carta de Netmultix',
      OTHER => 'Otro'
  }

  def get_type
    TYPES[self.file_type]
  end

  def delete_file
    remove_file!
  end

end
