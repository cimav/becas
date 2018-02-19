class InternshipFile < SaposModels
  mount_uploader :file, InternshipFileUploader

  NORMAL              = 1
  SIGN_REQUEST        = 2
  INSTITUTION_REQUEST = 3
  REGISTRATION_PROOF  = 4
  PHOTO               = 5
  COURSE              = 6

  REQUESTED_DOCUMENTS = {
      NORMAL              => 'Documento genérico',
      SIGN_REQUEST        => 'Solicitud con firmas',
      INSTITUTION_REQUEST => 'Solicitud oficial de la institución de procedencia',
      REGISTRATION_PROOF  => 'Constancia de inscripción de institución de procedencia',
      COURSE              => 'Curso de seguridad e higiene aprobado'
  }

end