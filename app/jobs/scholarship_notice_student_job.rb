class ScholarshipNoticeStudentJob < ApplicationJob
  queue_as :default

  def perform(scholarship_id, person_id, person_type)
    scholarship = Scholarship.find(scholarship_id)
    #student = person_type.constantize.find(person_id)
    student = User.first

    if !scholarship.scholarship_token
      scholarship.build_scholarship_token(token: (Digest::SHA256.hexdigest DateTime.now.to_s), status:ScholarshipToken::ACTIVE).save
    end
    ScholarshipsMailer.notice_student(scholarship,student).deliver_now
  end
end
