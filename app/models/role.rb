class Role < ActiveRecord::Base
  has_many :assignments
  has_many :positions, class_name: Volunteer::Position
  has_many :users, through: :assignments

  attr_accessible :title

  validates_uniqueness_of :title

  before_save :downcase_title

  def self.[](title)
    find_or_create_by_title format_title(title)
  end

  def self.format_title(value)
    value = value.to_s unless value.is_a? String
    value.parameterize.underscore
  end

  def title=(value)
    write_attribute :title, Role.format_title(value)
  end

  private

  def downcase_title
    title.downcase!
  end

end
