require 'spec_helper'

describe Volunteer::Role do
  it { should belong_to :reports_to }
  it { should have_and_belong_to_many :preferred_by }
  it { should have_many :supporting_roles }

  it { should validate_presence_of :title }
  it { should validate_presence_of :default_checkin_at }
  it { should validate_presence_of :default_starts_at }
  it { should validate_presence_of :default_ends_at }

  describe 'converts to string' do
    context 'with program' do
      let(:program) { create :frc_program }
      subject { build :volunteer_role, title: 'Super important role', program: program }

      it { expect(subject.to_s).to eq 'FRC:Super important role' }
    end

    context 'without program' do
      subject { build :volunteer_role, title: 'Another role' }

      it { expect(subject.to_s).to eq 'No Program:Another role' }
    end
  end
end
