require 'spec_helper'

describe FirstProgram do
  let(:program) { build :frc_program }

  it { expect(subject).to have_many :games }

  it { should validate_presence_of :name }
  it { should validate_presence_of :code }
  it { should validate_uniqueness_of :code }

  it { expect(program.to_s).to eq(program.name) }
end
