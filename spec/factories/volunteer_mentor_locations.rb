# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :volunteer_mentor_location, :class => 'Volunteer::MentorLocation' do
    name "MyString"
    latitude 1.5
    longitude 1.5
    profile nil
  end
end
