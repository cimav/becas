module ApplicationHelper
  def active_class(link_path)
    "active" if request.path.start_with?(link_path)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_staff
    @current_staff ||= Staff.find(session[:user_id]) if session[:user_id]
  end


  def is_admin?
    if (user = current_user if session[:user_type].eql? 'User')
      user.user_type == User::ADMIN || current_user.user_type == User::SUPER_USER
    end
  end

end
