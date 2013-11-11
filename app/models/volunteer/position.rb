class Volunteer::Position < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :volunteers, through: :assignments, class_name: Volunteer::Registration, source: :registration
  belongs_to :event
  belongs_to :role

  attr_accessible :needed_count, :role_id

  delegate :title, to: :role


  def available_volunteers
    assigned_volunteers = assignments.map(&:registration_id)
    query = event.volunteer_registrations.joins(:profile).
        order("LOWER(profiles.first_name) ASC, LOWER(profiles.last_name) ASC")
    if assigned_volunteers.count > 0
      query.where("volunteer_registrations.id NOT IN (?)", assigned_volunteers)
    else
      query
    end
  end

  def fullfillment
    assignments.count.to_f / needed_count.to_f
  end

  def responsible_for
    subordinate_roles = role.subordinates.map(&:id)
    event.positions.where("volunteer_roles.id IN (?)", subordinate_roles)
  end
end
