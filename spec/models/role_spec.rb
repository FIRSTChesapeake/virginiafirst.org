require 'spec_helper'

describe Role do
  it { should belong_to :reports_to }
  it { should have_many :supporting_roles }

  it { should validate_presence_of :title }

  it "converts to string" do
    role = build :role, title: "Super Important Guy"
    expect(role.to_s).to eq "Super Important Guy"
  end
end
