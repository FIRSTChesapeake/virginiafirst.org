class Volunteer::Assignment < ActiveRecord::Base
  belongs_to :position
  belongs_to :registration
  attr_accessible :ends_at, :registration_id, :starts_at
end
