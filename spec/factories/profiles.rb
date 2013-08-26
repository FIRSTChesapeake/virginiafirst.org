# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    user_id 1
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    street "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    latitude 1.5
    longitude 1.5
    age "MyString"
    primary_phone_type "MyString"
    primary_phone_number "MyString"
    alternate_phone_type "MyString"
    alternate_phone_number "MyString"
    current_organization "MyString"
    current_occupation "MyString"
    shirt_size "MyString"
    administrative_skill "MyString"
    interpersonal_skill "MyString"
    mechanical_skill "MyString"
    technical_skill "MyString"
    special_needs "MyText"
    volunteer_experience "MyText"
    first_alumnus false
    virginiafirst_alumnus false
  end
end
