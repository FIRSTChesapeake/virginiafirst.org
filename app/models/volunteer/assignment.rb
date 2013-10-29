class Volunteer::Assignment < ActiveRecord::Base
  belongs_to :position
  belongs_to :registration

  attr_accessible :ends_at, :position_id, :registration_id, :starts_at
end
