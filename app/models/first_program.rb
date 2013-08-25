class FirstProgram < ActiveRecord::Base
  attr_accessible :abbr, :code, :flag, :icon, :name

  has_many :events, foreign_key: "program_id"
  has_many :games, foreign_key: "program_id"

  mount_uploader :icon, IconUploader
  mount_uploader :flag, FlagUploader

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code

  def to_s
    name
  end
end
