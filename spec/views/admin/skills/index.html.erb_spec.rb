require 'spec_helper'

describe 'admin/skills/index.html.erb' do
  extend_abilities

  before(:each) do
    assign(:skills, [
        stub_model(Skill, :name => "CNC Operator"),
        stub_model(Skill, :name => "Accounting")
    ])
  end

  describe 'when rendered' do
    before(:each) { render }

    it { expect(rendered).to match /CNC Operator/ }
    it { expect(rendered).to match /Accounting/ }
    it { expect(rendered).not_to match /Edit/ }
    it { expect(rendered).not_to match /Delete/ }
  end

  context 'authorized ability' do
    it 'can edit skill' do
      @ability.can :edit, Skill
      render
      expect(rendered).to match /Edit/
    end

    it 'can delete skill' do
      @ability.can :delete, Skill
      render
      expect(rendered).to match /Delete/
    end
  end
end