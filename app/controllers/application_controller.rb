class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :is_admin?
  helper_method :current_user
  include ApplicationHelper

  def authenticated?
    if session[:user_auth].blank?
      logger.info "############### |#{session[:user_email]}|"
      user = User.where(:email => session[:user_email]).first
      logger.info "############### |#{user.email rescue "NULL"}|"

      session[:user_auth] = user && user.email == session[:user_email]
      if session[:user_auth]
        session[:user_id] = user.id
      end
    else
      session[:user_auth]
    end
  end

  def auth_required
    redirect_to '/login' unless authenticated?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
