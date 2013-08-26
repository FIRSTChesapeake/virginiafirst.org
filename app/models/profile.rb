class Profile < ActiveRecord::Base
  belongs_to :user

  attr_accessible :first_name, :last_name, :email, :age, :shirt_size
  attr_accessible :city, :state, :street, :zip
  attr_accessible :primary_phone_type, :primary_phone_number, :alternate_phone_type, :alternate_phone_number
  attr_accessible :current_occupation, :current_organization
  attr_accessible :administrative_skill, :interpersonal_skill, :mechanical_skill, :technical_skill
  attr_accessible :special_needs, :volunteer_experience
  attr_accessible :first_alumnus, :virginiafirst_alumnus

  enum_attr :age, %w(13-18 19-24 25-34 35-44 45-54 55+)
  enum_attr :shirt_size, %w(small medium large xl 2xl 3xl)
  enum_attr :administrative_skill, %w(low medium high)
  enum_attr :interpersonal_skill, %w(low medium high)
  enum_attr :mechanical_skill, %w(low medium high)
  enum_attr :technical_skill, %w(low medium high)

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

end
