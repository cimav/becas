module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_admin?
    current_user.user_type == User::ADMIN || current_user.user_type == User::SUPER_USER
  end

end
