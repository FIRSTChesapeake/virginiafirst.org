require 'spec_helper'

describe 'admin/volunteer/roles/index.html.erb' do
  extend_abilities

  before(:each) do
    assign(:roles, [
        stub_model(Volunteer::Role, attributes_for(:volunteer_role, title: "FTA")),
        stub_model(Volunteer::Role, attributes_for(:volunteer_role, title: "Judge"))
    ])
  end

  describe 'when rendered' do
    before(:each) { render }

    it { expect(rendered).to match /FTA/ }
    it { expect(rendered).to match /Judge/ }
    it { expect(rendered).not_to match /Edit/ }
    it { expect(rendered).not_to match /Delete/ }
  end

  context 'authorized ability' do
    it 'can edit role' do
      @ability.can :edit, Volunteer::Role
      render
      expect(rendered).to match /Edit/
    end

    it 'can delete role' do
      @ability.can :delete, Volunteer::Role
      render
      expect(rendered).to match /Delete/
    end
  end
end