class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :is_admin?
  helper_method :current_user
  include ApplicationHelper

  def authenticated?
    if session[:user_auth].blank?
      user_access
    else
      session[:user_auth]
    end
  end

  def user_access
    user = User.where(:email => session[:user_email]).first
    session[:user_auth] = user && user.email == session[:user_email]

    if session[:user_auth]
      session[:user_id] = user.id
      session[:user_type] = 'User'
    else
      # Si no existe un usuario busca en docentes
      staff_access
    end
  end

  def staff_access
    staff = Staff.where(:email => session[:user_email]).first
    session[:user_auth] = staff && staff.email == session[:user_email]

    if session[:user_auth]
      session[:user_id] = staff.id
      session[:user_type] = 'Staff'
    end
  end

  def auth_required
    redirect_to '/login' unless authenticated?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
