require 'spec_helper'

describe User do
  let(:user) { build :user }

  it { should have_many :providers }
  it { should have_one :volunteer_profile }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }

  it "requires password when not using omniauth provider" do
    expect(user.password_required?).to eq(true)
  end

  it "does not require password with omniauth provider" do
    user.providers.build provider: "omniauth-provider", uid: "1234"
    expect(user.password_required?).to eq(false)
  end

  context "with omniauth parameters" do
    it "loads an existing user" do
      user = create :user
      uid = generate_uid(:test)
      user.providers.create provider: :test, uid: uid
      OmniAuth.config.add_mock :test, { uid: uid }

      expect(User.from_omniauth(OmniAuth.config.mock_auth[:test])).to eq(user)
    end

    it "creates a new user" do
      attributes = attributes_for :user, first_name: "Walter", last_name: "White"
      OmniAuth.config.add_mock :test, { uid: generate_uid(:test), info: attributes }
      user = User.from_omniauth(OmniAuth.config.mock_auth[:test])

      expect(user).to be_an_instance_of(User)
      expect(user.first_name).to eq("Walter")
      expect(user.last_name).to eq("White")
    end

    it "builds a new user with invalid parameters" do
      OmniAuth.config.add_mock :test, { uid: generate_uid(:test) }
      user = User.from_omniauth(OmniAuth.config.mock_auth[:test])

      expect(user).to be_a_new(User)
      expect(user.valid?).to be_false
    end
  end

  it { expect(user.to_s).to eq(":#{user.first_name} #{user.last_name} <#{user.email}>") }
end
