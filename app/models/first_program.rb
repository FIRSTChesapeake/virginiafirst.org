class FirstProgram < ActiveRecord::Base
  attr_accessible :abbr, :code, :flag, :icon, :name

  has_many :events, foreign_key: "program_id"
  has_many :games, foreign_key: "program_id"

  mount_uploader :icon, IconUploader
  mount_uploader :flag, FlagUploader

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code

  def to_param
    code
  end

  def to_s
    name
  end

  def upcoming_events
    events.where("starts_at >= ?", Time.now)
  end

  def self.with_upcoming_events
    includes(:events).
        where("events.id is not null and starts_at >= ?", Time.now).
        order("events.starts_at ASC")
  end
end
