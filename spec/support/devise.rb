
RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.before(:each, :type => :controller) do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
end