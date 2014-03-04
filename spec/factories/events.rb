# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event, aliases: [:frc_event] do
    name "A Factory FRC Event"
    starts_at "2013-08-25 18:02:24"
    setup_at "2013-08-25 18:02:24"
    teardown_at "2013-08-25 18:02:24"
    venue "Stadium Arena"
    street "123 Main St"
    city "Metropolis"
    state "VA"
    zip "12345"
    code "VA"
    participant_limit 20
    association :program, factory: :frc_program
  end
end
