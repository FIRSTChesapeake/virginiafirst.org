class AmbassadorForm
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  class << self
    def model_name
      ActiveModel::Name.new(self, nil, 'Profile')
    end
  end

  delegate :email, :password, :password_confirmation, to: :user
  delegate :first_name, :last_name, :primary_phone_type, :primary_phone_number, to: :profile

  def errors
    profile.errors
  end

  def persisted?
    false
  end

  def profile
    @profile ||= Profile.new(primary_phone_type: :mobile)
  end

  def user
    @user ||= profile.build_user
  end

  def valid?
    profile.valid?
  end

  private

  def method_missing(method, *args, &block)
    profile.try(method, *args)
  end
end

