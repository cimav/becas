class InternshipFile < SaposModels
  mount_uploader :file, InternshipFileUploader

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

  REQUESTED_DOCUMENTS = {
      NORMAL              => 'Documento genérico',
      SIGN_REQUEST        => 'Solicitud con firmas',
      INSTITUTION_REQUEST => 'Solicitud oficial de la institución de procedencia',
      REGISTRATION_PROOF  => 'Constancia de estudios',
      COURSE              => 'Curso de seguridad e higiene aprobado',
      IFE                 => 'Credencial del INE o IFE',
      BANK_ACCOUNT        => 'Cuenta bancaria',
      CURP                => 'CURP',
      ADDRESS_BILL        => 'Comprobante de domicilio',
      WORKPLAN            => 'Plan de trabajo',
      INSURANCE           => 'Seguro médico',
      CIMAV_CREDENTIAL    => 'Credencial del CIMAV'
  }

  def get_document_text
    REQUESTED_DOCUMENTS[self.file_type]
  end

end