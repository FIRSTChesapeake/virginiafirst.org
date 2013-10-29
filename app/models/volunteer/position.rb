class Volunteer::Position < ActiveRecord::Base
  belongs_to :event
  belongs_to :role
  attr_accessible :needed_count, :role_id
end
