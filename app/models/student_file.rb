class StudentFile < SaposModels
  mount_uploader :file, StudentFileUploader

  NORMAL              = 1
  SIGN_REQUEST        = 2
  INSTITUTION_REQUEST = 3
  REGISTRATION_PROOF  = 4
  PHOTO               = 5
  COURSE              = 6
  IFE                 = 7
  BANK_ACCOUNT        = 8
  CURP                = 9
  ADDRESS_BILL        = 10
  WORKPLAN            = 11
  INSURANCE           = 12
  CIMAV_CREDENTIAL    = 13
  ACTIVITY_REPORT    = 14

  REQUESTED_DOCUMENTS = {
      NORMAL              => 'Documento genérico',
      INSTITUTION_REQUEST => 'Solicitud oficial de la institución de procedencia',
      WORKPLAN            => 'Plan de trabajo',
  }

  def get_document_text
    REQUESTED_DOCUMENTS[self.file_type]
  end

end