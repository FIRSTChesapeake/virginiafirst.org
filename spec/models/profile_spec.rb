require 'spec_helper'

describe Profile do
  it { should belong_to :user }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should ensure_inclusion_of(:age).in_array(%w(13-18 19-24 25-34 35-44 45-54 55+)) }
  it { should ensure_inclusion_of(:shirt_size).in_array([:small, :medium, :large, :xl, "2xl", "3xl"]) }
  it { should ensure_inclusion_of(:administrative_skill).in_array([:low, :medium, :high]) }
  it { should ensure_inclusion_of(:interpersonal_skill).in_array([:low, :medium, :high]) }
  it { should ensure_inclusion_of(:mechanical_skill).in_array([:low, :medium, :high]) }
  it { should ensure_inclusion_of(:technical_skill).in_array([:low, :medium, :high]) }
end
