require 'spec_helper'

describe Volunteer::EventsController do
  let(:event) { create :event }

  context 'when signed out' do
    describe "GET 'index'" do
      before(:each) { get :index }

      it { expect(response).not_to be_success }
    end

    describe "GET 'show'" do
      before(:each) { get :show, { id: event.to_param } }

      it { expect(response).not_to be_success }
    end
  end

  context 'when signed in' do
    let(:user) { create :admin }
    before(:each) { sign_in user }

    describe "GET 'index'" do
      before(:each) { get :index }

      it { expect(response).to be_success }
      it { expect(assigns(:events)).to eq [event] }
    end

    describe "GET 'show'" do
      before(:each) { get :show, { id: event.to_param } }

      it { expect(response).to be_success }
      it { expect(assigns(:event)).to eq event }
    end

  end
end
