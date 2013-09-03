class Skill < ActiveRecord::Base
  has_and_belongs_to_many :profiles

  attr_accessible :is_administrative, :is_mechanical, :is_technical, :name

  validates_presence_of :name

  def to_s
    name
  end
end
