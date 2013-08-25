class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    #raise request.env["omniauth.auth"].to_yaml
    user = User.from_omniauth request.env["omniauth.auth"]
    if user.persisted?
      flash.notice = I18n.t :signed_in, scope: [:devise, :sessions]
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :open_id, :all
end
