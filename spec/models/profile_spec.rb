require 'spec_helper'

describe Profile do
  let(:profile) { build :profile }

  it { should belong_to :user }
  it { should have_and_belong_to_many :skills }
  it { should have_and_belong_to_many :preferred_roles }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :primary_phone_type }
  it { should validate_presence_of :primary_phone_number }
  it { should ensure_inclusion_of(:age).in_array(%w(13-18 19-24 25-34 35-44 45-54 55+)) }
  it { should ensure_inclusion_of(:shirt_size).in_array([:small, :medium, :large, :xl, :xxl, :xxxl]) }
  it { should ensure_inclusion_of(:primary_phone_type).in_array([:home, :mobile, :work, :other]) }
  it { should ensure_inclusion_of(:alternate_phone_type).in_array([:home, :mobile, :work, :other]) }

  context "without first_name" do
    let(:profile) { build :profile, first_name: "" }
    before(:each) { profile.valid? }

    it { expect(profile.valid?).to be_false }
    it { expect(profile.new_record?).to be_true }
    it { expect(profile.errors.full_messages.to_s).to match /First name can't be blank/ }
    it { expect(profile.errors.full_messages.to_s).to match /Name is missing first name/ }
  end

  context "without last_name" do
    let(:profile) { build :profile, last_name: "" }
    before(:each) { profile.valid? }

    it { expect(profile.valid?).to be_false }
    it { expect(profile.new_record?).to be_true }
    it { expect(profile.errors.full_messages.to_s).to match /Last name can't be blank/ }
    it { expect(profile.errors.full_messages.to_s).to match /Name is missing last name/ }
  end

  context "without first_name and last_name" do
    let(:profile) { build :profile, first_name: "", last_name: "" }
    before(:each) { profile.valid? }

    it { expect(profile.errors.full_messages.to_s).to match /Name is missing first name, last name/ }
  end

  it "builds full name" do
    profile = build :profile, first_name: "Fred", last_name: "Thompson"
    expect(profile.full_name).to eq "Fred Thompson"
  end

  it "capitalizes full name" do
    profile = build :profile, first_name: "fred", last_name: "thompson"
    expect(profile.full_name).to eq "Fred Thompson"
  end

  context "with formatted phone number" do
    it "strips characters from primary phone number" do
      profile = build :profile, primary_phone_number: "(555) 123-4567"
      profile.valid?
      expect(profile.primary_phone_number).to eq "5551234567"
    end

    it "strips characters from alternate phone number" do
      profile = build :profile, alternate_phone_number: "+1.888.717.2012"
      profile.valid?
      expect(profile.alternate_phone_number).to eq "+18887172012"
    end
  end

  context "without primary_phone_type and with primary_phone_number" do
    let(:profile) { build :profile, primary_phone_type: "", primary_phone_number: "5551234567" }
    before(:each) { profile.valid? }

    it { expect(profile.valid?).to be_false }
    it { expect(profile.errors.full_messages.to_s).to match /Primary phone is incomplete/ }
  end

  context "without primary_phone_number and with primary_phone_type" do
    let(:profile) { build :profile, primary_phone_type: :mobile, primary_phone_number: "" }
    before(:each) { profile.valid? }

    it { expect(profile.valid?).to be_false }
    it { expect(profile.errors.full_messages.to_s).to match /Primary phone is incomplete/ }
  end

  context "without alternate_phone_number and with alternate_phone_type" do
    let(:profile) { build :profile, alternate_phone_type: :home, alternate_phone_number: "" }
    before(:each) { profile.valid? }

    it { expect(profile.valid?).to be_false }
    it { expect(profile.errors.full_messages.to_s).to match /Alternate phone is incomplete/ }
    it { expect(profile.errors.full_messages.to_s).to match /Alternate phone number can't be blank/ }
  end

  context "without alternate_phone_type and with alternate_phone_number" do
    let(:profile) { build :profile, alternate_phone_type: nil, alternate_phone_number: "5551234567" }
    before(:each) { profile.valid? }

    it { expect(profile.valid?).to be_false }
    it { expect(profile.errors.full_messages.to_s).to match /Alternate phone is incomplete/ }
    it { expect(profile.errors.full_messages.to_s).to match /Alternate phone type can't be blank/ }
  end

  context "with alternate_phone_number and alternate_phone_type" do
    let(:profile) { build :profile, alternate_phone_type: :work, alternate_phone_number: "8889876543" }

    it { expect(profile.valid?).to be_true }
  end

  context "without zip" do
    let(:profile) { build :profile, zip: nil }

    context "without city" do
      before(:each) do
        profile.city = nil
        profile.valid?
      end

      it { expect(profile.valid?).to be_false }
      it { expect(profile.errors.full_messages.to_s).to match /Address is missing city or zip/ }
    end

    context "without state" do
      before(:each) do
        profile.state = nil
        profile.valid?
      end

      it { expect(profile.valid?).to be_false }
      it { expect(profile.errors.full_messages.to_s).to match /Address is missing state or zip/ }
    end
  end

  context "without city, state, zip" do
    let(:profile) { build :profile, city: nil, state: nil, zip: nil }
    before(:each) { profile.valid? }

    it { expect(profile.valid?).to be_false }
    it { expect(profile.errors.full_messages.to_s).to match /Address is missing city and state or zip/ }
  end
end
