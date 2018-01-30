module ApplicationHelper
  def active_class(link_path)
    "active" if request.fullpath.start_with?(link_path)
  end

  def current_user
    if session[:user_type].eql?'User'
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    else
      @current_user ||= Staff.find(session[:user_id]) if session[:user_id]
    end
  end



  def is_admin?
    current_user.user_type == User::ADMIN || current_user.user_type == User::SUPER_USER
  end

end
