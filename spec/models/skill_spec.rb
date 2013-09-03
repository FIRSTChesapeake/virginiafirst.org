require 'spec_helper'

describe Skill do
  it { should validate_presence_of :name }

  it "converts to string" do
    skill = build :skill, name: "Amazing superpower"
    expect(skill.to_s).to eq("Amazing superpower")
  end
end
