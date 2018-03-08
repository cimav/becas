class ApplicationController < ActionController::Base
  before_action :auth_required
  protect_from_forgery with: :exception
  include ApplicationHelper

  def  authenticated?
    if session[:user_auth].blank?
      user = User.where(:email => session[:user_email], :status => User::ACTIVE).first || Staff.where("(email = ? ) AND status = ?",session[:user_email], Staff::ACTIVE).first
      set_user_type(user)
      session[:user_auth] = user && user.email == session[:user_email]

      if session[:user_auth]
        session[:user_id] = user.id
      end
    else
      session[:user_auth]
    end
  end

  def set_user_type(user)
    if user.class.name.eql?'User'
      session[:user_type] = 'User'
    else
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
