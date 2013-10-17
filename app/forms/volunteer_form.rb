class VolunteerForm

  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveRecord::Reflection

  attr_writer :current_step

  create_reflection :has_many, :preferred_roles, {}, Profile.new

  delegate :preferred_roles, to: :profile

  def initialize(user)
    @user = user
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      profile.valid?
    end
  end

  def current_step
    @current_step || steps.first
  end

  def errors
    profile.errors
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def persisted?
    false
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def profile
    @profile ||= (user.profile || user.build_profile)
  end

  def submit
    if profile.save!
      VolunteerMailer.registration(profile).deliver
      true
    else
      false
    end
  end

  def steps
    steps = []
    steps << 'personal' if profile.new_record?
    steps << 'preferences' if profile.new_record? || profile.preferred_roles.empty?
    steps << 'events'
    steps
  end

  def user
    @user
  end

  def valid?
    profile.valid?
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Profile")
  end

  private

  def method_missing(method, *args, &block)
    profile.try(method, *args)
  end
end