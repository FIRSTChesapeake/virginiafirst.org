require 'spec_helper'

describe Volunteer::Reports::CrewBreakDownController do
  let(:user) { create :volunteer_coordinator }
  let(:event) { create :event }

  before(:each) { sign_in user }

  describe 'GET "show"' do
    before(:each) { get :show, { event_id: event.to_param } }

    it { expect(response).to be_success }
  end

end
