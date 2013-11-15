class Volunteer::MentorLocation < ActiveRecord::Base
  belongs_to :profile

  attr_accessible :name

  geocoded_by :name
  after_validation :geocode
end
