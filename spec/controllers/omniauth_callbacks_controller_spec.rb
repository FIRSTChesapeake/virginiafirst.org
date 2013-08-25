require 'spec_helper'

describe OmniauthCallbacksController do
  context "OpenID authentication" do
    context "creates a new user" do
      before(:each) do
        user = attributes_for :user
        auth = { uid: generate_uid(:open_id), info: user }
        setup_omniauth_env(:open_id, auth)
        get :open_id
      end

      it { expect(subject.current_user).not_to be_nil }
      it { expect(flash[:notice]).to eq("Signed in successfully.") }
      it { expect(response).to redirect_to root_url }
    end

    context "signs in an existing user" do
      let(:user) { create :user }

      before(:each) do
        uid = generate_uid(:open_id)
        user.providers.create provider: :open_id, uid: uid
        setup_omniauth_env(:open_id, { uid: uid, info: user.attributes })
        get :open_id
      end

      it { expect(subject.current_user).to eq(user) }
      it { expect(flash[:notice]).to eq("Signed in successfully.") }
      it { expect(response).to redirect_to root_url }
    end
  end

  context "with invalid authentication parameters" do
    before(:each) do
      auth = { uid: generate_uid(:open_id) }
      setup_omniauth_env(:open_id, auth)
      get :open_id
    end

    it { expect(response).to redirect_to new_user_registration_path }
  end

  def setup_omniauth_env(provider, auth)
    OmniAuth.config.add_mock(provider, auth)
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[provider]
  end
end
