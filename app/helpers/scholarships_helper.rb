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
    end
  end

  def enable_cep_button(scholarship)
    if scholarship.agreement
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

end
