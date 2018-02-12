class HomeController < ApplicationController
  before_action :auth_required

  def index
    if session[:user_type].eql? 'User'
      @scholarships = Scholarship.where.not(status:Scholarship::DELETED).order("CASE
                                WHEN status = #{Scholarship::REQUESTED} THEN 1
                                WHEN status = #{Scholarship::APPROVED} THEN 2
                                WHEN status = #{Scholarship::ACTIVE} THEN 3
                                WHEN status = #{Scholarship::REJECTED} THEN 4
                                WHEN status = #{Scholarship::INACTIVE} THEN 5
                              END")
      render template: 'home/user_index'
    else
      # se ordena por estatus de manera personalizada
      @scholarships = Scholarship.where(person_type:'Internship').where.not(status:Scholarship::DELETED).where(person_id:(Internship.where(staff_id:current_staff.id).pluck(:id)))
                          .order("CASE
                                WHEN status = #{Scholarship::ACTIVE} THEN 1
                                WHEN status = #{Scholarship::APPROVED} THEN 2
                                WHEN status = #{Scholarship::REQUESTED} THEN 3
                                WHEN status = #{Scholarship::REJECTED} THEN 4
                                WHEN status = #{Scholarship::INACTIVE} THEN 5
                              END")
      render template: 'home/staff_index'
    end
  end

end
