class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_up_path_for(resource)
    volunteer_registration_path
  end
end
