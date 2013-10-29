class Event < ActiveRecord::Base
  belongs_to :game
  has_many :positions, class_name: Volunteer::Position
  belongs_to :program, class_name: "FirstProgram"
  has_many :volunteer_registrations, class_name: Volunteer::Registration
  has_many :volunteer_profiles, through: :volunteer_registrations

  scope :sorted, ->(order='ASC') { order("starts_at #{order}") }
  scope :upcoming, -> { where("starts_at > ?", Date.today).order("starts_at ASC") }

  attr_accessible :name, :participant_limit, :program_id
  attr_accessible :setup_at, :starts_at, :teardown_at
  attr_accessible :city, :state, :street, :venue, :zip
  attr_accessible :positions_attributes

  accepts_nested_attributes_for :positions, allow_destroy: true

  validates_presence_of :name
  validates_presence_of :program
  validate :address_is_provided

  geocoded_by :full_address
  after_validation :geocode

  def full_address
    fields = [street, city, state, zip]
    fields.delete_if { |f| f.blank? }
    fields.join(", ")
  end

  def to_s
    name
  end

  def unused_roles
    if positions.count > 0
      Volunteer::Role.where("id NOT IN (?)", positions.map(&:role_id))
    else
      Volunteer::Role.all
    end
  end

  private

  def address_is_provided
    required_fields = [:street, :city, :state, :zip]
    errors.add_on_blank(required_fields)

    missing_fields = errors.keys & required_fields
    if missing_fields.present?
      humanize = missing_fields.map { |f| f.to_s.humanize }
      errors.add(:address, "is missing #{humanize.join(", ")}")
      false
    end
    true
  end
end
