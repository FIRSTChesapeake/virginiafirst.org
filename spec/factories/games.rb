# Read about factories at https://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :game, aliases: [:frc_game] do
    name "Ultimate Ascent"
    season 2013
    starts_at "2013-01-07 08:00:00"
    ends_at "2014-04-29 16:00:00"
    logo { fixture_file_upload Rails.root.join(*%w[spec fixtures images UltimateAscent.jpg]) }
    association :program, factory: :frc_program
  end

  factory :ftc_game, class: "Game" do
    name "Ring It Up!"
    Season 2013
    starts_at "2012-09-07 08:00:00"
    ends_at "2013-04-29 16:00:00"
    logo { fixture_file_upload Rails.root.join(*%w[spec fixtures images ring-it-up-web_600x560.png]) }
    association :program, factory: :ftc_program
  end
end
