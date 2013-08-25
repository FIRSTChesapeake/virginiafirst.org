class Volunteer::Profile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :age, :confirmed_age, :occupation, :organization, :shirt_size
  attr_accessible :administrative_skill, :interpersonal_skill
  attr_accessible :mechanical_skill, :technical_skill
  attr_accessible :first_experience, :volunteer_experience

  enum_attr :age, %w[13-18 19-24 25-34 35-44 45-54 55+]
  enum_attr :administrative_skill, %w[low medium high]
  enum_attr :interpersonal_skill, %w[low medium high]
  enum_attr :mechanical_skill, %w[low medium high]
  enum_attr :technical_skill, %w[low medium high]
  enum_attr :shirt_size, %w[small medium large xl 2xl 3xl]

  validates_presence_of :user
  validates_presence_of :age
  validates_presence_of :administrative_skill
  validates_presence_of :interpersonal_skill
  validates_presence_of :mechanical_skill
  validates_presence_of :technical_skill
  validates_acceptance_of :confirmed_age, allow_nil: false, accept: true
end
