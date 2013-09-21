class Volunteer::Registration < ActiveRecord::Base
  belongs_to :profile
  belongs_to :event

  attr_accessible :will_setup, :will_teardown

  validates_presence_of :event_id
  validates_presence_of :profile_id
end
