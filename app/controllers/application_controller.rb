class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_up_path_for(resource)
    volunteer_registration_path
  end

  def after_sign_in_path_for(resource)
    if session[:return_to]
      url = session[:return_to]
      session[:return_to] = nil
      url
    else
      super
    end
  end

  def remember_return_url
    session[:return_to] ||= params[:return_to]
  end
  before_filter :remember_return_url
end
