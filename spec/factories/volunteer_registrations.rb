# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :volunteer_registration, :class => 'Volunteer::Registration' do
    will_setup false
    will_teardown false
    profile
    event
  end
end
