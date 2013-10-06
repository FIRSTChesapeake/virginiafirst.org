# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    first_name "Calvin"
    last_name "Jones"
    street "5739 Fairview Way"
    city "Raleigh"
    state "NC"
    zip "27511"
    age "13-18"
    primary_phone_type "mobile"
    primary_phone_number "5551234567"
    current_organization "Acme Corp"
    current_occupation "Project Manager"
    shirt_size :small
    first_alumnus true
    virginiafirst_alumnus true
    user
  end
end
