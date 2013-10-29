require 'spec_helper'

describe 'admin/events/index.html.erb' do
  extend_abilities

  before(:each) do
    assign(:events, [
        stub_model(Event, attributes_for(:event, name: "An Event")),
        stub_model(Event, attributes_for(:event, name: "Some Game"))
    ])
  end

  describe 'when rendered' do
    before(:each) { render }

    it { expect(rendered).to match /An Event/ }
    it { expect(rendered).to match /Some Game/ }
    it { expect(rendered).not_to match /Delete/ }
    it { expect(rendered).not_to match /Edit/ }
  end

  context 'authorized ability' do
    it 'can delete event' do
      @ability.can :delete, Event
      render
      expect(rendered).to match /Delete/
    end

    it 'can edit event' do
      @ability.can :edit, Event
      render
      expect(rendered).to match /Edit/
    end
  end
end