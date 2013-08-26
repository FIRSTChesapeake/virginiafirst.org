require 'spec_helper'

describe Admin::EventsController do
  let!(:event) { create :event }

  describe "GET 'index'" do
    before(:each) do
      get 'index'
    end

    it { expect(response).to be_success }
  end

  describe "GET 'new'" do
    before(:each) do
      get 'new'
    end

    it { expect(assigns(:event)).to be_a_new(Event) }
    it { expect(response).to be_success }
  end

  describe "POST 'create'" do
    let(:program) { create :frc_program }
    let(:valid_attributes) { attributes_for :event, program_id: program.id }
    let(:invalid_attributes) { {} }

    context "persistence" do
      it "succeeds with valid attributes" do
        expect {
          post :create, {event: valid_attributes}
        }.to change(Event, :count).by(1)
      end

      it "fails with invalid attributes" do
        expect {
          post :create, {event: invalid_attributes}
        }.to change(Event, :count).by(0)
      end
    end

    context "with valid params" do
      before(:each) do
        post :create, {event: valid_attributes}
      end

      it { expect(assigns(:event)).to be_a(Event) }
      it { expect(assigns(:event)).to be_persisted }
      it { expect(response).to redirect_to admin_event_path(nil, assigns(:event)) }
    end

    context "with invalid params" do
      before(:each) do
        post :create, {event: invalid_attributes}
      end

      it { expect(response).to render_template('new') }
      it { expect(assigns(:event)).to be_a_new(Event) }
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      get 'edit', { id: event.to_param }
    end

    it { expect(response).to be_success }
    it { expect(assigns(:event)).to eq(event) }
  end

  describe "PUT 'update'" do
    it "updates the event" do
      Event.any_instance.should_receive(:update_attributes).with({"name" => "I'm Changed!"})
      put :update, {id: event.to_param, event: {name: "I'm Changed!"}}
    end

    context "with valid params" do
      before(:each) do
        put :update, {id: event.to_param, event: {name: "New Name"}}
      end

      it { expect(assigns(:event)).to eq(event) }
      it { expect(assigns(:event).name).to eq("New Name") }
      it { expect(response).to redirect_to admin_event_path(nil, assigns(:event)) }
    end

    context "with invalid params" do
      before(:each) do
        put :update, {id: event.to_param, event: {name: ""}}
      end

      it { expect(assigns(:event)).to eq(event) }
      it { expect(response).to render_template 'edit' }
    end
  end

  describe "GET 'show'" do
    before(:each) do
      get 'show', { id: event.to_param }
    end

    it { expect(response).to be_success }
    it { expect(assigns(:event)).to eq(event) }
  end

  describe "DELETE 'destroy'" do
    it "deletes the event" do
      expect {
        delete :destroy, {id: event.to_param}
      }.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      delete :destroy, {id: event.to_param}
      expect(response).to redirect_to admin_events_path(nil)
    end
  end
end
