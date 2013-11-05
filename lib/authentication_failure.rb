class AuthenticationFailure < Devise::FailureApp
  def redirect_url
    if warden_options[:scope] == :user
      new_user_registration_path(return_to: params[:return_to])
    else
      new_user_registration_path
    end
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end