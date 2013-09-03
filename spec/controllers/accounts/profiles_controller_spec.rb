require 'spec_helper'

describe Accounts::ProfilesController do
  let(:profile) { create :profile }
  let(:user) { profile.user }

  describe "GET 'edit'" do
    context "signed in" do
      before(:each) do
        sign_in user
        get 'edit'
      end

      it { expect(response).to be_success }
      it { expect(assigns(:profile)).to eq(profile) }
    end
  end

  describe "POST 'create'" do
    let(:user) { create :user }

    context "signed in" do
      before(:each) { sign_in user}

      context "with valid profile" do
        let(:valid_attributes) { attributes_for :profile }
        before(:each) { post :create, { profile: valid_attributes } }

        it { expect(response).to redirect_to edit_profile_path }
      end

      context "with invalid profile" do
        let(:invalid_attributes) { {} }
        before(:each) { post :create, { profile: invalid_attributes } }

        it { expect(response).to render_template :edit }
      end
    end
  end

  describe "PUT 'update'" do
    context "signed in" do
      before(:each) { sign_in user }

      context "with valid profile" do
        let(:valid_attributes) { { first_name: "John" } }
        before(:each) { put :update, { profile: valid_attributes } }

        it { expect(response).to redirect_to edit_profile_path }
      end

      context "with invalid profile" do
        let(:invalid_attributes) { { first_name: "" } }
        before(:each) { put :update, { profile: invalid_attributes } }

        it { expect(response).to render_template :edit }
      end
    end
  end

end
