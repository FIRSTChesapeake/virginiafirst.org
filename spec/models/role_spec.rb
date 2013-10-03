require 'spec_helper'

describe Role do
  it { expect(subject).to have_many :assignments }
  it { expect(subject).to have_many :users }

  it { expect(subject).to validate_uniqueness_of :title }
  it "converts title to lowercase" do
    role = Role.create title: "test role"
    expect(role.title).to eq "test_role"
  end
end
