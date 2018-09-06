module ScholarshipsHelper
  def status_color(status)
    color = ''
    case status
      when Scholarship::REQUESTED
        color = 'orange-text text-lighten-2'
      when Scholarship::APPROVED
        color = 'blue-text text-lighten-2'
      when Scholarship::ACTIVE
        color = 'green-text'
      when Scholarship::INACTIVE
        color = 'grey-text'
      when Scholarship::TO_COMMITTEE
        color = 'purple-text'
      when Scholarship::REJECTED
        color = 'red-text'
      when Scholarship::CANCELED
        color = 'black-text'
    end
  end

  def enable_cep_button(scholarship)
    if scholarship.agreement
      'disabled'
    elsif scholarship.scholarship_files.where(file_type: ScholarshipFile::CEP_DOCUMENT).size > 0
      'disabled'
    elsif scholarship.person_type == 'Internship'
      if !scholarship_all_documents?(scholarship)
        'disabled'
      end
    end
  end

  def scholarship_all_documents?(scholarship)
    document_types = ['REGISTRATION_PROOF', 'INSTITUTION_REQUEST', 'IFE', 'BANK_ACCOUNT', 'CURP', 'ADDRESS_BILL', 'WORKPLAN', 'INSURANCE', 'CIMAV_CREDENTIAL', 'COURSE']
    document_types.each do |document_type|
      if !scholarship.person.internship_files.where(file_type:InternshipFile.const_get(document_type)).last
        return false
      end
    end
    true
  end

  def multiple_scholarship?(scholarship)
    if !scholarship.person.curp.blank?
      #se buscan becas que no estén inactivas, rechazadas o eliminadas que correspondan al mismo curp
      (Scholarship.joins("INNER JOIN #{SaposModels.db_name}.students p ON scholarships.person_id = p.id").where(person_type:'Student').where("p.curp ='#{scholarship.person.curp}'").where.not(status: [Scholarship::DELETED, Scholarship::INACTIVE, Scholarship::REJECTED, Scholarship::CANCELED]).size > 1) || (Scholarship.joins("INNER JOIN #{SaposModels.db_name}.internships p ON scholarships.person_id = p.id").where(person_type:'Internship').where("p.curp ='#{scholarship.person.curp}'").where.not(status: [Scholarship::DELETED, Scholarship::INACTIVE, Scholarship::REJECTED, Scholarship::CANCELED]).size > 1)
    else
      false
    end
  end

end
