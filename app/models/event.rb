class Event < ActiveRecord::Base
  belongs_to :game
  belongs_to :program, class_name: "FirstProgram"

  attr_accessible :name, :participant_limit, :program_id
  attr_accessible :setup_at, :starts_at, :teardown_at
  attr_accessible :city, :state, :street, :venue, :zip

  validates_presence_of :name
  validates_presence_of :program
  validate :address_is_provided

  def to_s
    name
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
