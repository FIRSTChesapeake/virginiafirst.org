class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth request.env["omniauth.auth"]
    session[:return_to] = request.env["omniauth.origin"]
    if user.persisted?
      flash.notice = I18n.t :signed_in, scope: [:devise, :sessions]
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :open_id, :all
  alias_method :google_oauth2, :all
end
