require 'spec_helper'

describe Volunteer::Role do
  it { should belong_to :reports_to }
  it { should have_and_belong_to_many :preferred_by }
  it { should have_many :supporting_roles }

  it { should validate_presence_of :title }
  it { should validate_presence_of :default_checkin_at }
  it { should validate_presence_of :default_starts_at }
  it { should validate_presence_of :default_ends_at }

  it "converts to string" do
    role = build :volunteer_role, title: "Super Important Guy"
    expect(role.to_s).to eq "Super Important Guy"
  end
end
