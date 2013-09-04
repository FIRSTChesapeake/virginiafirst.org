class Profile < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :preferred_roles, class_name: "Role"

  attr_accessible :first_name, :last_name, :email, :age, :shirt_size
  attr_accessible :city, :state, :street, :zip
  attr_accessible :primary_phone_type, :primary_phone_number
  attr_accessible :alternate_phone_type, :alternate_phone_number
  attr_accessible :current_occupation, :current_organization
  attr_accessible :administrative_skill, :interpersonal_skill, :mechanical_skill, :technical_skill
  attr_accessible :special_needs, :volunteer_experience
  attr_accessible :first_alumnus, :virginiafirst_alumnus
  attr_accessible :preferred_role_ids, :skill_ids

  enum_attr :age, %w(13-18 19-24 25-34 35-44 45-54 55+)
  enum_attr :shirt_size, %w(small medium large xl 2xl 3xl)
  enum_attr :administrative_skill, %w(low medium high)
  enum_attr :interpersonal_skill, %w(low medium high)
  enum_attr :mechanical_skill, %w(low medium high)
  enum_attr :technical_skill, %w(low medium high)
  enum_attr :primary_phone_type, %w(home mobile work other)
  enum_attr :alternate_phone_type, %w(home mobile work other)

  validates_presence_of :email
  validate :requires_full_name
  validate :requires_address
  validate :requires_primary_phone
  validate :alternate_phone_is_complete

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
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
