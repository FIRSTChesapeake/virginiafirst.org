class Game < ActiveRecord::Base
  belongs_to :program, class_name: "FirstProgram"

  attr_accessible :ends_at, :logo, :name, :program_id, :season, :starts_at

  mount_uploader :logo, LogoUploader

  validates_presence_of :name
  validates_presence_of :program
  validates_presence_of :season
  validates_numericality_of :season, greater_than_or_equal_to: 1992, only_integer: true, allow_nil: true

  def to_s
    "#{season}:#{name}"
  end
end
