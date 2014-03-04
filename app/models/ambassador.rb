class Ambassador < ActiveRecord::Base
  belongs_to :profile
  belongs_to :event
  # attr_accessible :title, :body
end
