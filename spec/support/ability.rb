
module AbilityMacros
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end
end

RSpec.configure do |config|
  config.include AbilityMacros, type: :view
end