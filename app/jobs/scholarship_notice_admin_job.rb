class ScholarshipNoticeAdminJob < ApplicationJob
  queue_as :default

  def perform(scholarship_id, user_id)
    scholarship = Scholarship.find(scholarship_id)
    user = User.find(user_id)
    ScholarshipsMailer.notice_admin(scholarship, user).deliver_now
  end
end
