require 'spec_helper'

describe Volunteer::Profile do
  it { should belong_to :user }

  it { should validate_presence_of :user }
  it { should validate_presence_of :age }
  it { should validate_presence_of :administrative_skill }
  it { should validate_presence_of :interpersonal_skill }
  it { should validate_presence_of :mechanical_skill }
  it { should validate_presence_of :technical_skill }
  it { should validate_acceptance_of :confirmed_age }
  it { should ensure_inclusion_of(:age).in_array(%w(13-18 19-24 25-34 35-44 45-54 55+)) }
  it { should ensure_inclusion_of(:administrative_skill).in_array([:low, :medium, :high]) }
  it { should ensure_inclusion_of(:interpersonal_skill).in_array([:low, :medium, :high]) }
  it { should ensure_inclusion_of(:mechanical_skill).in_array([:low, :medium, :high]) }
  it { should ensure_inclusion_of(:technical_skill).in_array([:low, :medium, :high]) }
  it { should ensure_inclusion_of(:shirt_size).in_array([:small, :medium, :large, :xl, "2xl", "3xl"]) }
end
