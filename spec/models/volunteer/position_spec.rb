require 'spec_helper'

describe Volunteer::Position do
  it { should validate_numericality_of(:needed_count).only_integer }
  it { should validate_numericality_of(:needed_count).is_greater_than_or_equal_to(1) }
end
