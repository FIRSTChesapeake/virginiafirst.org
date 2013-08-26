require 'spec_helper'

describe Event do
  it { expect(subject).to belong_to :program }

  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to validate_presence_of :program }

  it "converts to string" do
    event = build :event, name: "Random event title"
    expect(event.to_s).to eq("Random event title")
  end

  context "validates address" do
    context "without street" do
      let(:event) { build :event, street: nil }
      before(:each) { event.valid? }

      it { expect(event).not_to be_valid }
      it { expect(event.errors[:street].to_s).to match(/can't be blank/) }
      it { expect(event.errors[:address].to_s).to match(/is missing Street/) }
    end

    context "without city" do
      let(:event) { build :event, city: nil }
      before(:each) { event.valid? }

      it { expect(event).not_to be_valid }
      it { expect(event.errors[:city].to_s).to match(/can't be blank/) }
      it { expect(event.errors[:address].to_s).to match(/is missing City/) }
    end

    context "without state" do
      let(:event) { build :event, state: nil }
      before(:each) { event.valid? }

      it { expect(event).not_to be_valid }
      it { expect(event.errors[:state].to_s).to match(/can't be blank/) }
      it { expect(event.errors[:address].to_s).to match(/is missing State/) }
    end

    context "without zip" do
      let(:event) { build :event, zip: nil }
      before(:each) { event.valid? }

      it { expect(event).not_to be_valid }
      it { expect(event.errors[:zip].to_s).to match(/can't be blank/) }
      it { expect(event.errors[:address].to_s).to match(/is missing Zip/) }
    end
  end
end
