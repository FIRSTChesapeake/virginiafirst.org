class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, and :timeoutable
  devise :confirmable, :database_authenticatable, :registerable,
         :omniauthable, :recoverable, :rememberable, :trackable,
         :validatable

  has_many :providers, class_name: "AuthProvider"
  has_one :profile
  has_many :assignments
  has_many :roles, through: :assignments

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :current_password
  attr_accessible :remember_me

  def self.create_from_omniauth(auth)
    create do |user|
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

  def active_for_authentication?
    true
  end

  def add_role(title)
    if title.is_a? ::Role
      Assignment.create! user: self, role: title
    else
      roles << ::Role[title] unless has_role?(title)
    end
  end

  def has_role?(title)
    title = Role.format_title(title)
    !!roles.where(title: title).first
  end

  def is_superuser?
    !!roles.where(title: [:admin, :virginia_first, :ftc_admin, :frc_admin]).first
  end

  def password_required?
    super && providers.blank?
  end

  def to_s
    "#{id}:#{email}"
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
