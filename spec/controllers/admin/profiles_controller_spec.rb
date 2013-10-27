require 'spec_helper'

describe Admin::ProfilesController do

  context "when signed in" do
    let(:user) { create :admin }
    let!(:profile) { create :profile }
    before(:each) { sign_in user }

    describe "GET 'index'" do
      before(:each) { get :index }

      it { expect(response).to be_success }
      it { expect(assigns(:profiles)).to eq [profile] }
    end

    describe "GET 'show'" do
      before(:each) { get :show, id: profile.to_param }

      it { expect(response).to be_success }
    end

  end

end
