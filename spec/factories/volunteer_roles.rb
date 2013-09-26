# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :volunteer_role, class: Volunteer::Role do
    title "Ordinary role"
    description "This is just an ordinary role."
    default_checkin_at "2013-09-03 17:42:17"
    default_starts_at "2013-09-03 17:42:17"
    default_ends_at "2013-09-03 17:42:17"
    default_number_needed 5
    key_position false

    factory :key_volunteer_role do
      title "Key role"
      description "This is a key role who has special responsibilities"
      default_number_needed 1
      key_position true
    end
  end
end
