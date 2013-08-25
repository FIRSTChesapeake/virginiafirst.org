require 'spec_helper'

describe Event do
  it { expect(subject).to belong_to :program }

  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to validate_presence_of :program }

  it "converts to string" do
    event = build :event, name: "Random event title"
    expect(event.to_s).to eq("Random event title")
  end
end
