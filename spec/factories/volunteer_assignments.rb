# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :volunteer_assignment, :class => 'Volunteer::Assignment' do
    registration_id 1
    position nil
    starts_at ""
    ends_at "2013-10-29 02:04:25"
  end
end
