class HomeController < ApplicationController
  before_action :auth_required

  def index
    @internships = Internship.all
  end
end
