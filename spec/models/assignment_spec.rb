require 'spec_helper'

describe Assignment do
  it { expect(subject).to belong_to :role }
  it { expect(subject).to belong_to :user }
end
