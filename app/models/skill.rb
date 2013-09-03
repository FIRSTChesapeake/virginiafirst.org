class Skill < ActiveRecord::Base
  attr_accessible :is_administrative, :is_mechanical, :is_technical, :name

  validates_presence_of :name

  def to_s
    name
  end
end
