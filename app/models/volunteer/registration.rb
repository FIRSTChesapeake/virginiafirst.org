class Volunteer::Registration < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :positions, through: :assignments
  belongs_to :profile
  belongs_to :event

  attr_accessible :event_id, :will_setup, :will_teardown

  validates_presence_of :event
  #validates_presence_of :profile

  delegate :full_name, to: :profile
end
