require 'spec_helper'

describe Volunteer::ProfilesController do

  context 'when signed in' do
    let(:user) { create :volunteer_coordinator }
    before(:each) { sign_in user }

    describe "GET 'index'" do
      let(:event) { create :event }
      before(:each) { get :index, { event_id: event.to_param } }

      it { expect(response).to be_success }
    end

    describe "GET 'show'" do
      let(:profile) { create :profile }
      before(:each) { get :show, { id: profile.to_param } }

      it { expect(response).to be_success }
    end
  end
end
