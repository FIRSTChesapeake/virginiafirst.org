class Role < ActiveRecord::Base
  belongs_to :reports_to, class_name: "Role", conditions: {key_position: true}
  has_many :supporting_roles, class_name: "Role", foreign_key: "reports_to_id"

  scope :key_positions, where(key_position: true)

  attr_accessible :title, :description, :key_position, :reports_to_id
  attr_accessible :default_checkin_at, :default_ends_at, :default_starts_at
  attr_accessible :default_number_needed

  validates_presence_of :title

  def to_s
    title
  end
end
