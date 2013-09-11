require 'spec_helper'

describe Game do
  it { expect(subject).to belong_to :program }
  it { expect(subject).to have_many :events }

  it { should validate_presence_of :name }
  it { should validate_presence_of :program }
  it { should validate_presence_of :season }
  it { should validate_numericality_of(:season).only_integer }

  it "converts to string" do
    game = build :game, name: "Test Game", season: 2000
    expect(game.to_s).to eq("2000:Test Game")
  end
end
