
module AbilityMacros
  def extend_abilities
    before(:each) do
      @ability = Object.new
      @ability.extend(CanCan::Ability)
      controller.stub(:current_ability) { @ability }
    end
  end
end

RSpec.configure do |config|
  config.extend AbilityMacros, type: :view
end