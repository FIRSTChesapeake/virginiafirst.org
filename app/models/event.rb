class Event < ActiveRecord::Base
  belongs_to :program, class_name: "FirstProgram"

  attr_accessible :name, :participant_limit, :program_id
  attr_accessible :setup_at, :starts_at, :teardown_at
  attr_accessible :city, :state, :street, :venue, :zip

  validates_presence_of :name
  validates_presence_of :program

  def to_s
    name
  end
end
