class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, and :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :providers, class_name: "AuthProvider"
  has_one :profile
  has_one :volunteer_profile, class_name: "Volunteer::Profile"

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.create_from_omniauth(auth)
    create do |user|
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.providers.build auth.slice(:provider, :uid)
    end
  end

  def self.from_omniauth(auth)
    user = AuthProvider.where(auth.slice(:provider, :uid)).first.try(:user)
    user || create_from_omniauth(auth)
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def password_required?
    super && providers.blank?
  end

  def to_s
    "#{id}:#{full_name} <#{email}>"
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
