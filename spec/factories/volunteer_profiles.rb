# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :volunteer_profile, :class => 'Volunteer::Profile' do
    user_id 1
    age "MyString"
    occupation "MyString"
    organization "MyString"
    technical_skill "MyString"
    administrative_skill "MyString"
    interpersonal_skill "MyString"
    mechanical_skill "MyString"
    first_experience "MyText"
    volunteer_experience "MyText"
    confirmed_age false
    shirt_size "MyString"
  end
end
