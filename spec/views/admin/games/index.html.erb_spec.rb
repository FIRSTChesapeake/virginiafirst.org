require 'spec_helper'

describe 'admin/games/index.html.erb' do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }

    assign(:games, [
        stub_model(Game, :name => "Stack Attack"),
        stub_model(Game, :name => "Rebound Rumble")
    ])
  end

  describe "when rendered" do
    before(:each) { render }

    it { expect(rendered).to match /Stack Attack/ }
    it { expect(rendered).to match /Rebound Rumble/ }
    it { expect(rendered).not_to match /Edit/ }
    it { expect(rendered).not_to match /Delete/ }
  end

  context 'authorized ability' do
    it 'can edit game' do
      @ability.can :edit, Game
      render
      expect(rendered).to match /Edit/
    end

    it 'can delete game' do
      @ability.can :delete, Game
      render
      expect(rendered).to match /Delete/
    end
  end
end