class Profile < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :preferred_roles, class_name: Volunteer::Role
  has_many :volunteer_registrations, class_name: Volunteer::Registration
  has_many :volunteer_events, through: :volunteer_registrations, source: :event

  scope :sorted, order("lower(last_name) ASC, lower(first_name) ASC")

  attr_accessible :first_name, :last_name, :age, :shirt_size
  attr_accessible :city, :state, :street, :zip
  attr_accessible :primary_phone_type, :primary_phone_number
  attr_accessible :alternate_phone_type, :alternate_phone_number
  attr_accessible :current_occupation, :current_organization
  attr_accessible :is_administrative, :is_interpersonal, :is_mechanical, :is_technical
  attr_accessible :has_other_skill, :other_skill
  attr_accessible :special_needs, :volunteer_experience
  attr_accessible :first_alumnus, :virginiafirst_alumnus
  attr_accessible :preferred_role_ids, :skill_ids
  attr_accessible :is_student, :is_parent, :is_mentor, :is_sponsor, :is_volunteer
  attr_accessible :has_frc_experience, :frc_team_number
  attr_accessible :has_ftc_experience, :ftc_team_number
  attr_accessible :has_fll_experience, :has_jrfll_experience
  attr_accessible :volunteer_event_ids
  attr_accessible :volunteer_registrations_attributes

  accepts_nested_attributes_for :volunteer_registrations,
                                allow_destroy: true,
                                reject_if: proc { |attr| attr['event_id'].blank? }

  enum_attr :age, %w(13-18 19-24 25-34 35-44 45-54 55+)
  enum_attr :primary_phone_type, %w(home mobile work other)
  enum_attr :alternate_phone_type, %w(home mobile work other)
  enum_attr :shirt_size, %w(small medium large xl xxl xxxl) do
    label :xl => "XL"
    label :xxl => "2XL"
    label :xxxl => "3XL"
  end

  validate :requires_full_name
  validate :requires_address
  validate :requires_primary_phone
  validate :alternate_phone_is_complete

  def alternate_phone_type_label
    enums(:alternate_phone_type).label(alternate_phone_type)
  end

  def first_involvement
    involvement = []
    involvement << "Student" if is_student?
    involvement << "Parent" if is_parent?
    involvement << "Mentor" if is_mentor?
    involvement << "Sponsor" if is_sponsor?
    involvement << "Volunteer" if is_volunteer?
    involvement
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def primary_phone_type_label
    enums(:primary_phone_type).label(primary_phone_type)
  end

  def skill_characteristics
    skills = []
    skills << :administrative if is_administrative?
    skills << :interpersonal if is_interpersonal?
    skills << :mechanical if is_mechanical?
    skills << :technical if is_technical?
    skills
  end

  before_validation :clean_up_phone_numbers

  private

  def clean_up_phone_numbers
    primary_phone_number.gsub! /[^0-9x+]/, '' if primary_phone_number.present?
    alternate_phone_number.gsub! /[^0-9x+]/, '' if alternate_phone_number.present?
  end

  def alternate_phone_is_complete
    fields = [:alternate_phone_number, :alternate_phone_type]
    errors.add_on_blank(:alternate_phone_number) if alternate_phone_type.present?
    errors.add_on_blank(:alternate_phone_type) if alternate_phone_number.present?
    validates_presence_of_group :alternate_phone, fields
  end

  def requires_address
    fields = [:city, :state, :zip]
    errors.add_on_blank(fields[0..1]) if zip.blank?
    errors.add_on_blank(fields[2]) if city.blank? || state.blank?
    validates_presence_of_group :address, fields do |missing|
      message = "is missing"
      if missing.include?(:city) && missing.include?(:state)
        message += " city and state"
      elsif missing.include?(:city)
        message += " city"
      elsif missing.include?(:state)
        message += " state"
      end
      if missing.include? :zip
        message += " or zip"
      end
      message
    end
  end

  def requires_full_name
    fields = [:first_name, :last_name]
    errors.add_on_blank(fields)
    validates_presence_of_group :name, fields do |missing|
      humanized_fields = missing.map { |f| f.to_s.humanize.downcase }.join(", ")
      "is missing #{humanized_fields}"
    end
  end

  def requires_primary_phone
    fields = [:primary_phone_type, :primary_phone_number]
    errors.add_on_blank(fields)
    validates_presence_of_group :primary_phone, fields
  end

  def validates_presence_of_group(name, fields)
    missing_fields = errors.keys & fields
    if missing_fields.present?
      errors.add(name, block_given? ? yield(missing_fields) : "is incomplete")
      false
    end
    true
  end
end
