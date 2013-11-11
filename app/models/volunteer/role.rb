class Volunteer::Role < ActiveRecord::Base
  belongs_to :program, class_name: FirstProgram
  belongs_to :reports_to, class_name: "Role", conditions: {key_position: true}
  has_and_belongs_to_many :preferred_by, class_name: "Profile"
  has_many :supporting_roles, class_name: "Role", foreign_key: "reports_to_id"
  has_many :subordinates, class_name: Volunteer::Role, foreign_key: "reports_to_id", uniq: true

  attr_accessible :title, :description, :key_position, :reports_to_id
  attr_accessible :default_checkin_at, :default_ends_at, :default_starts_at
  attr_accessible :program_id
  attr_accessible :default_number_needed

  validates_presence_of :title
  validates_presence_of :default_checkin_at
  validates_presence_of :default_starts_at
  validates_presence_of :default_ends_at

  def self.key_positions(program=nil)
    query = where(key_position: true)
    query = query.where(program_id: program.id) if program.present?
    query
  end

  def to_s
    "#{program.try(:abbr) || 'No Program'}:#{title}"
  end

end
