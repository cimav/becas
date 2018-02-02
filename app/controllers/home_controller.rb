class HomeController < ApplicationController
  before_action :auth_required

  def index
    if session[:user_type].eql? 'User'
      render template: 'home/user_index'
    else
      render template: 'home/staff_index'
    end
  end

  def staff_index
    @internships = Internship.where(staff_id:current_staff.id).where(status:Internship::ACTIVE)
  end

  def user_index
    @internships = Internship.all
  end

  def get_internship
    render json:Internship.find(params[:id]), :include => {:internship_type => {:only => :name}}
  end

  def get_scholarship_type
    render json:ScholarshipType.find(params[:id])
  end

end
