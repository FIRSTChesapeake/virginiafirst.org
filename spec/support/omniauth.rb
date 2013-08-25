OmniAuth.config.test_mode = true

module OmniAuthMacros
  def generate_uid(provider)
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless AuthProvider.where(provider: provider, uid: random_token).exists?
    end
  end
end

RSpec.configure do |config|
  config.include OmniAuthMacros
end
