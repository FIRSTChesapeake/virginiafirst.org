require 'spec_helper'

describe Volunteer::RegistrationsController do

  context 'not signed in' do
    describe 'GET "show"' do
      before(:each) { get :show }
      it { expect(response).not_to be_success }
      it { expect(response).to redirect_to new_user_registration_path }
    end
  end

  context 'signed in' do
    let(:profile) { create :profile }
    let(:user) { profile.user }
    before(:each) { sign_in user }

    describe 'GET "show"' do
      let!(:event) { create :event }
      before(:each) { get :show }
      it { expect(response).to be_success }
      it { expect(assigns(:profile)).to eq profile }
    end

    context 'with program parameter' do
      let(:program) { create :frc_program_with_roles }
      describe 'GET "show"' do
        before(:each) { get :show, { program: program.to_param } }
        it { expect(assigns(:program)).to eq program }
        it { expect(assigns(:programs)).to eq [program] }
      end
    end
  end

end